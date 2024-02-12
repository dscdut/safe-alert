import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_template/common/extensions/string_extension.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';

abstract class ValidatorUtil {
  static String? validateEmail(String? value) {
    if (value != null) {
      if (!value.isEmail) {
        return LocaleKeys.validator_invalid_email.tr();
      }
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value != null) {
      if (!value.isPhoneNumber || value.length < 10) {
        return LocaleKeys.validator_invalid_phone_number.tr();
      }
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value != null) {
      if (!value.isValidPassword) {
        return LocaleKeys.validator_invalid_password.tr();
      }
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validator_field_required.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value != null) {
      if (value != password) {
        return LocaleKeys.validator_not_match_password.tr();
      } else if (value.isEmpty) {
        return LocaleKeys.validator_field_required.tr();
      }
    }

    return null;
  }
}
