class LoginByPhoneNumberRequestDTO {
  LoginByPhoneNumberRequestDTO({
    required this.phoneNumber,
    required this.password,
  });
  final String phoneNumber;
  final String password;

  Map<String, dynamic> toJson() => _LoginByPhoneNumberRequestDTOToJson(this);

  Map<String, dynamic> _LoginByPhoneNumberRequestDTOToJson(
    LoginByPhoneNumberRequestDTO instance,
  ) =>
      <String, dynamic>{
        'phoneNumber': instance.phoneNumber,
        'password': instance.password,
      };
}
