import 'package:flutter_template/data/dtos/auth/refresh_token_dto.dart';
import 'package:flutter_template/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponseDTO {
  LoginResponseDTO({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  final UserModel user;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  RefreshTokenDTO toRefreshTokenDTO() {
    return RefreshTokenDTO(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}
