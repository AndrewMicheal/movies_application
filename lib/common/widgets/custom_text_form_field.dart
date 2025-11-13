import 'package:flutter/material.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_styles.dart';

typedef onValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {

  Color borderSideColor;
  String? hintText;
  // String? labelText;
  TextStyle? hintStyle;
  // TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  onValidator? validator;
  Color? textColor;
  // TextInputType? keyboardType;
  bool obscureText;
  String? obscuringCharacter;
  TextEditingController? controller;
  Color? textFormFieldBacgroundColor;

  CustomTextFormField({
    super.key,
    this.borderSideColor = AppColors.darkGray,
    this.hintText,
    // this.labelText,
    this.hintStyle,
    // this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    // this.keyboardType = TextInputType.text ,
    this.obscureText = false,
    this.obscuringCharacter,
    required this.controller,
    this.textColor,
    this.textFormFieldBacgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter ?? "*",
      validator: validator,
      style: TextStyle(
        color: textColor ?? AppColors.whiteColor
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: textFormFieldBacgroundColor ?? AppColors.darkGray,
        enabledBorder: builtDecorationBorder(borderSideColor: borderSideColor),
        focusedBorder: builtDecorationBorder(borderSideColor: borderSideColor),
        errorBorder: builtDecorationBorder(borderSideColor: AppColors.redColor),
        focusedErrorBorder: builtDecorationBorder(
          borderSideColor: AppColors.redColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.regular16RobotoWhite ,
        // labelText: labelText,
        // labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  OutlineInputBorder builtDecorationBorder({required Color borderSideColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderSideColor, width: 1),
    );
  }
}
