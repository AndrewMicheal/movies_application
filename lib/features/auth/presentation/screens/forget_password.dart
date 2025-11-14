import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/widgets/custom_elevated_buttom.dart';
import '../../../../common/widgets/custom_text_form_field.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/assets_manager.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/validators.dart';
import '../../../../core/translation_extension.dart';
import '../cubit/reset_password/reset_passowrd_state.dart';
import '../cubit/reset_password/reset_password_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();

  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3NDFkMGFkODZlM2ZmZmIwM2IzOGEwOCIsImVtYWlsIjoiYW1yMjRAZ21haWwuY29tIiwiaWF0IjoxNzMyMzY4MDQ1fQ.vhf0NBQzj8EE9AinCX3ezu4yz1R8CNpt8xBawnTyMhw";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(context.tr("reset_success"))));
        }

        if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;

        return Scaffold(
          backgroundColor: AppColors.nearBlack,
          appBar: AppBar(
            backgroundColor: AppColors.nearBlack,
            centerTitle: true,
            foregroundColor: AppColors.yellow,
            title: Text(
              context.tr("resetPassword"),
              style: AppStyles.regular16RobotoYellow,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(AssetsManager.forgotPasswordImage),

                  const SizedBox(height: 16),

                  // Old Password
                  CustomTextFormField(
                    controller: oldPassController,
                    hintText: context.tr("oldPassword"),
                    prefixIcon: Icon(Icons.lock, color: AppColors.whiteColor),
                    validator: (v) =>
                        ResetValidators.validateOldPassword(context, v ?? ""),
                  ),

                  const SizedBox(height: 16),

                  // New Password
                  CustomTextFormField(
                    controller: newPassController,
                    hintText: context.tr("newPassword"),
                    prefixIcon:
                    Icon(Icons.lock_outline, color: AppColors.whiteColor),
                    validator: (v) => ResetValidators.validateNewPassword(
                      context,
                      oldPassController.text,
                      v ?? "",
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButtom(
                      text: isLoading
                          ? "Loading..."
                          : context.tr("resetPassword"),
                      onPressed: isLoading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ResetPasswordCubit>().resetPassword(
                            token: token,
                            oldPassword: oldPassController.text,
                            newPassword: newPassController.text,
                          );
                        }
                      },
                      textStyle: AppStyles.regular20RobotoDarkGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
