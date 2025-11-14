import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/common/widgets/custom_elevated_buttom.dart';
import 'package:movies/common/widgets/custom_text_form_field.dart';
import 'package:movies/common/widgets/sliding_switch.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_routes.dart';
import 'package:movies/core/app_styles.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/translation_extension.dart';
import 'package:movies/core/validators.dart';
import 'package:movies/features/auth/presentation/cubit/login_cubit.dart';
import 'package:movies/features/auth/presentation/cubit/login_state.dart';
import 'package:movies/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(
    text: "andrew0@test.com",
  );
  final _loginFormKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController(
    text: "Aaa090!@",
  );
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Loading..."),
                behavior: SnackBarBehavior.floating,
                duration: Duration(milliseconds: 800),
              ),
            );
          }

          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Success Login"),
                behavior: SnackBarBehavior.floating,
              ),
            );

            Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
          }

          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoadingState;
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.nearBlack,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    Image.asset(AssetsManager.loginSplashScreen),
                    SizedBox(height: 70.h),
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: emailController,
                            validator: (v) =>
                                Validators.validateEmail(context, v ?? ""),
                            hintText: context.tr("email"),
                            prefixIcon: Image.asset(AssetsManager.iconMessage),
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomTextFormField(
                            controller: passwordController,
                            validator: (v) =>
                                Validators.validatePassword(context, v ?? ""),
                            hintText: context.tr("password"),
                            prefixIcon: Image.asset(AssetsManager.iconPassword),
                            obscureText: !isSelected,
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              },
                              child: Icon(
                                isSelected
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                        ],
                      ),
                    ),

                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.forget_password,
                          style: AppStyles.regular14RobotoYellow,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButtom(
                           onPressed: !isLoading
                            ? () {
                          if (_loginFormKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                              
                               emailController.text,
                               passwordController.text,
    
                            );
                          }
                        }
                            : null,
                        text: AppLocalizations.of(context)!.login,
                        textStyle: AppStyles.regular20RobotoDarkGrey,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.registerScreen,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.dont_have_account} ? ",
                            style: AppStyles.regular14RobotoWhite,
                          ),
                          Text(
                            AppLocalizations.of(context)!.create_one,
                            style: AppStyles.bold14RobotoYellow,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.yellow,
                            thickness: 2,
                            indent: size.width * 0.04,
                            endIndent: size.width * 0.04,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.or,
                          style: AppStyles.regular15RobotoWhite.copyWith(
                            color: AppColors.yellow,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.yellow,
                            thickness: 2,
                            indent: size.width * 0.04,
                            endIndent: size.width * 0.04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomElevatedButtom(
                      onPressed: () {},
                      hasIcon: true,
                      text: "",
                      childIconWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsManager.iconGoogle),
                          SizedBox(width: size.width * 0.03),
                          Text(
                            AppLocalizations.of(context)!.login_with_google,
                            style: AppStyles.regular16RobotoDarkGrey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    SlidingSwitch(
                      firstImage: Image.asset(AssetsManager.americaIcon),
                      secondImage: Image.asset(AssetsManager.egyptIcon),
                      onToggle: (index) {
                        setState(() {
                          print(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
