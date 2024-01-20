import 'package:flutter_template/data/dtos/auth/refresh_token_dto.dart';
import 'package:flutter_template/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createToJson: false)
class LoginResponseDTO {
  LoginResponseDTO({
    required this.user,
    required this.accessToken,
  });

  final UserModel user;
  final String accessToken;
}
