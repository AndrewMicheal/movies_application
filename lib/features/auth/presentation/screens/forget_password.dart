import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/common/widgets/custom_elevated_buttom.dart';
import 'package:movies/common/widgets/custom_text_form_field.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_styles.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/translation_extension.dart';

import '../cubit/reset_password/reset_passowrd_state.dart';
import '../cubit/reset_password/reset_password_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();

  bool showOld = false;
  bool showNew = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.pop(context);
        } else if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;

        return Scaffold(
          backgroundColor: AppColors.nearBlack,
          appBar: AppBar(
            foregroundColor: AppColors.yellow,
            backgroundColor: AppColors.nearBlack,
            centerTitle: true,
            title: Text(
              context.tr("forget_password"),
              style: AppStyles.regular16RobotoYellow,
            ),
          ),

          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [

                    const SizedBox(height: 10),
                    Image.asset(
                      AssetsManager.forgotPasswordImage,
                    ),
                    const SizedBox(height: 10),

                    CustomTextFormField(
                      controller: oldPassController,
                      hintText: context.tr("oldPassword"),
                      prefixIcon: Icon(Icons.lock, color: AppColors.whiteColor),
                      obscureText: !showOld,
                      suffixIcon: InkWell(
                        onTap: () => setState(() => showOld = !showOld),
                        child: Icon(
                          showOld
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return context.tr("reset_old_required");
                        }
                        if (v.length < 6) {
                          return context.tr("reset_password_min_length");
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    CustomTextFormField(
                      controller: newPassController,
                      hintText: context.tr("newPassword"),

                      prefixIcon: Icon(Icons.lock, color: AppColors.whiteColor),
                      obscureText: !showNew,
                      suffixIcon: InkWell(
                        onTap: () => setState(() => showNew = !showNew),
                        child: Icon(
                          showNew
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return context.tr("reset_new_required");
                        }
                        if (v.length < 6) {
                          return context.tr("reset_password_min_length");
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButtom(
                        onPressed: !isLoading
                            ? () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ResetPasswordCubit>().resetPassword(
                              oldPassword: oldPassController.text,
                              newPassword: newPassController.text,
                            );
                          }
                        }
                            : null,
                        text: context.tr("changePassword"),
                        textStyle: AppStyles.regular20RobotoDarkGrey,
                      ),
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
