// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "texts": {
    "notification": "Notification",
    "success": "Success",
    "error_occur": "An error has occurred, please try again later",
    "full_name": "Full name",
    "email_address": "Email Address",
    "phone_number": "Phone number",
    "password": "Password",
    "confirm_password": "Confirm password",
    "remember_me": "Remember me",
    "forgot_password": "Forgot password?",
    "dont_have_account": "Don't have an account?"
    "you_have_an_account": "You have an account?"
  },
  "button": {
    "cancel": "Cancel",
    "confirm": "Confirm",
    "try_again": "Try again"
  },
  "root": {
    "home": "Home",
    "profile": "Profile",
    "management": "Management"
  },
  "auth": {
    "welcome_back": "Nice to have you back!",
    "sign_in": "Sign in"
  },
  "validator": {
    "email_required": "Please enter your email",
    "password_required": "Please enter your password",
    "invalid_email": "Invalid email address",
    "invalid_phone_number": "Invalid phone number",
    "incorrect_phone_number_password": "Incorrect phone number or password",
    "incorrect_email_password": "Incorrect email or password",
    "invalid_phone_number": "Incorrect phone number",
    "invalid_password": "Password must be at least 8 characters",
    "field_required": "This field is required",
    "not_match_password": "Password and confirm password not match",
    "email_or_phone_number_exists": "Email or phone number already exists"
  },
  "loading": {
    "ads": "Loading ads..."
  }
};
static const Map<String,dynamic> vi = {
  "texts": {
    "notification": "Thông báo",
    "success": "Thành công",
    "error_occur": "Đã có lỗi xảy ra, vui lòng thử lại sau",
    "full_name": "Họ và tên",
    "email_address": "Email",
    "password": "Mật khẩu"
  },
  "button": {
    "cancel": "Hủy",
    "confirm": "Xác nhận",
    "try_again": "Thử lại"
  },
  "root": {
    "home": "Trang chủ",
    "profile": "Cá nhân",
    "management": "Quản lý"
  },
  "auth": {
    "welcome_back": "Rất vui khi được gặp lại bạn!",
    "sign_in": "Đăng nhập"
  },
  "validator": {
    "email_required": "Vui lòng nhập email",
    "password_required": "Vui lòng nhập mật khẩu",
    "invalid_email": "Không đúng định dạng email",
    "invalid_phone_number": "Không đúng định dạng số điện thoại",
    "incorrect_phone_number_password": "Số điện thoại hoặc mật khẩu không đúng",
    "incorrect_email_password": "Email hoặc mật khẩu không đúng",
    "invalid_phone_number": "Không đúng định dạng số điện thoại",
    "invalid_password": "Mật khẩu phải có ít nhất 8 kí tự",
    "field_required": "Không được để trống",
    "not_match_password": "Mật khẩu xác nhận không trùng khớp",
    "email_or_phone_number_exists": "Email hoặc số điện thoại đã tồn tại"
  },
  "loading": {
    "ads": "Đang tải quảng cáo..."
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "vi": vi};
}
