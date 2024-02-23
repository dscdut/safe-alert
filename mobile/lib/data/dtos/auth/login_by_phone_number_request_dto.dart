class LoginByPhoneNumberRequestDTO {
  LoginByPhoneNumberRequestDTO({
    required this.phoneNumber,
    required this.password,
  });
  final String phoneNumber;
  final String password;

  Map<String, dynamic> toJson() => _loginByPhoneNumberRequestDTOToJson(this);

  Map<String, dynamic> _loginByPhoneNumberRequestDTOToJson(
    LoginByPhoneNumberRequestDTO instance,
  ) =>
      <String, dynamic>{
        'phoneNumber': instance.phoneNumber,
        'password': instance.password,
      };
}
