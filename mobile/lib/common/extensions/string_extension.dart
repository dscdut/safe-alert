extension StringExtension on String? {
  bool get isEmail {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this!);
  }

  bool get isPhoneNumber {
    return RegExp(
      r'^\d{10}$',
    ).hasMatch(this!);
  }

  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
