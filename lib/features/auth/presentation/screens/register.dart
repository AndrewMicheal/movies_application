import 'package:flutter/material.dart';
import '../../../../common/widgets/custom_elevated_buttom.dart';
import '../../../../common/widgets/custom_text_form_field.dart';
import '../../../../common/widgets/sliding_switch.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_routes.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/assets_manager.dart';
import '../../../../l10n/app_localizations.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController re_passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int selectedAvatarIndex = 1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.nearBlack,
      appBar: AppBar(
        foregroundColor: AppColors.yellow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(AppLocalizations.of(context)!.register, style: AppStyles.regular16RobotoYellow),

        centerTitle: true,
        backgroundColor: AppColors.nearBlack,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(avatars.length, (index) {
                  bool isSelected = selectedAvatarIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        final selected = avatars[index];
                        avatars.removeAt(index);
                        avatars.insert(1, selected);
                        selectedAvatarIndex = 1;
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

              Text("Avatar", style: AppStyles.regular16RobotoWhite),

              const SizedBox(height: 10),

              CustomTextFormField(
                controller: nameController,
                hintText: AppLocalizations.of(context)!.name,
                prefixIcon: Image.asset(AssetsManager.iconIdentification),
              ),
              SizedBox(height: size.height * 0.02),
              CustomTextFormField(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Icon(
                  Icons.email,
                  size: 35,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              CustomTextFormField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Image.asset(AssetsManager.iconPassword),
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              CustomTextFormField(
                controller: re_passwordController,
                hintText: AppLocalizations.of(context)!.confirmPassword,
                prefixIcon: Image.asset(AssetsManager.iconPassword),
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              CustomTextFormField(
                controller: phoneController,
                hintText: AppLocalizations.of(context)!.phoneNumber,
                prefixIcon: Image.asset(AssetsManager.iconPhone),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButtom(
                  onPressed: () {},
                  text: AppLocalizations.of(context)!.createAccount,
                  textStyle: AppStyles.regular20RobotoDarkGrey,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.loginScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.alreadyHaveAccount}? ",
                      style: AppStyles.regular14RobotoWhite,
                    ),
                    Text(
                      AppLocalizations.of(context)!.login,
                      style: AppStyles.bold14RobotoYellow,
                    ),
                  ],
                ),
              ),
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
  }

  final List<String> avatars = [
    AssetsManager.avatarImage1,
    AssetsManager.avatarImage2,
    AssetsManager.avatarImage3,
  ];
}
