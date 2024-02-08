import 'package:json_annotation/json_annotation.dart';
part 'register_response_dto.g.dart';

@JsonSerializable(createToJson: true)
class RegisterDTO {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  RegisterDTO({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDTOToJson(this);
}
