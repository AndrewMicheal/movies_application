import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/custom_elevated_buttom.dart';
import '../../../../common/widgets/custom_text_form_field.dart';
import '../../../../common/widgets/sliding_switch.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_routes.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/assets_manager.dart';
import '../../../../core/translation_extension.dart';
import '../../../../core/validators.dart';

import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final phoneController = TextEditingController();

  int selectedAvatarIndex = 0;

  final List<String> avatars = [
    AssetsManager.avatarImage1,
    AssetsManager.avatarImage2,
    AssetsManager.avatarImage3,
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Loading..."),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 800),
            ),
          );
        }

        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
            ),
          );

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.loginScreen,
          );
        }

        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },

      builder: (context, state) {
        final isLoading = state is RegisterLoading;

        return Scaffold(
          backgroundColor: AppColors.nearBlack,
          appBar: AppBar(
            foregroundColor: AppColors.yellow,
            backgroundColor: AppColors.nearBlack,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              context.tr("register"),
              style: AppStyles.regular16RobotoYellow,
            ),
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(avatars.length, (index) {
                        bool isSelected = selectedAvatarIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAvatarIndex = index;
                            });
                          },
                          child: CircleAvatar(
                            radius: isSelected ? 75 : 35,
                            backgroundImage: AssetImage(avatars[index]),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 12),
                    Text(context.tr("avatar"), style: AppStyles.regular16RobotoWhite),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      controller: nameController,
                      hintText: context.tr("name"),
                      prefixIcon: Image.asset(AssetsManager.iconIdentification),
                      validator: (v) => Validators.validateName(context, v ?? ""),
                    ),
                    SizedBox(height: size.height * 0.02),

                    CustomTextFormField(
                      controller: emailController,
                      hintText: context.tr("email"),
                      prefixIcon: Icon(Icons.email, color: AppColors.whiteColor, size: 35),
                      validator: (v) => Validators.validateEmail(context, v ?? ""),
                    ),
                    SizedBox(height: size.height * 0.02),

                    CustomTextFormField(
                      controller: passwordController,
                      hintText: context.tr("password"),
                      prefixIcon: Image.asset(AssetsManager.iconPassword),
                      suffixIcon: Icon(Icons.visibility_off, color: AppColors.whiteColor),
                      validator: (v) => Validators.validatePassword(context, v ?? ""),
                    ),
                    SizedBox(height: size.height * 0.02),

                    CustomTextFormField(
                      controller: confirmController,
                      hintText: context.tr("confirmPassword"),
                      prefixIcon: Image.asset(AssetsManager.iconPassword),
                      suffixIcon: Icon(Icons.visibility_off, color: AppColors.whiteColor),
                      validator: (v) => Validators.validateConfirmPassword(
                        context,
                        passwordController.text,
                        v ?? "",
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),

                    CustomTextFormField(
                      controller: phoneController,
                      hintText: context.tr("phoneNumber"),
                      prefixIcon: Image.asset(AssetsManager.iconPhone),
                      validator: (v) => Validators.validatePhone(context, v ?? ""),
                    ),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButtom(
                        text: context.tr("createAccount"),
                        textStyle: AppStyles.regular20RobotoDarkGrey,
                        onPressed: !isLoading
                            ? () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegisterCubit>().register(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: confirmController.text,
                              phone: phoneController.text,
                              avatarId: selectedAvatarIndex + 1,
                            );
                          }
                        }
                            : null,
                      ),
                    ),

                    SizedBox(height: size.height * 0.02),

                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.loginScreen),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.tr("alreadyHaveAccount"),
                              style: AppStyles.regular14RobotoWhite),
                          Text(context.tr("login"), style: AppStyles.bold14RobotoYellow),
                        ],
                      ),
                    ),

                    SlidingSwitch(
                      firstImage: Image.asset(AssetsManager.americaIcon),
                      secondImage: Image.asset(AssetsManager.egyptIcon),
                      onToggle: (index) {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
