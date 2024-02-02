extension StringExtension on String? {
  bool get isEmail {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this!);
  }

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isPhoneNumber {
    return RegExp(r'^([+]?[\s0-9]+)?(\d{3}|[(]?[0-9]+[)])?([-]?[\s]?[0-9])+$')
        .hasMatch(this!);
  }

  bool get isValidPassword{
    return RegExp(r'^[a-zA-Z0-9\\d@$!%*?&]{6,30}$').hasMatch(this!);
  }
}
