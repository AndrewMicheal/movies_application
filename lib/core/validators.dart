import 'package:flutter/material.dart';
import 'translation_extension.dart';

class Validators {
  static String? validateName(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.tr("name_required");
    }
    if (value.trim().length < 3) {
      return context.tr("name_short");
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.tr("email_required");
    }

    final emailRegex =
    RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");

    if (!emailRegex.hasMatch(value.trim())) {
      return context.tr("email_invalid");
    }

    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.tr("password_required");
    }

    if (value.length < 8) {
      return context.tr("password_short");
    }

    final strongRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$');

    if (!strongRegex.hasMatch(value)) {
      return context.tr("password_weak");
    }

    return null;
  }

  static String? validateConfirmPassword(
      BuildContext context, String? value, String original) {
    if (value == null || value.isEmpty) {
      return context.tr("confirm_required");
    }

    if (value != original) {
      return context.tr("confirm_not_match");
    }

    return null;
  }

  static String? validatePhone(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.tr("phone_required");
    }

    final regex = RegExp(r'^\+20[0-9]{9,10}$');

    if (!regex.hasMatch(value.trim())) {
      return context.tr("phone_invalid");
    }

    return null;
  }
}
