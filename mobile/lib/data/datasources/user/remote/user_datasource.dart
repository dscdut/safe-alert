import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/helpers/dio_helper.dart';
import 'package:flutter_template/data/dtos/auth/login_by_email_request_dto.dart';
import 'package:flutter_template/data/dtos/auth/login_response_dto.dart';
import 'package:flutter_template/data/dtos/auth/register_response_dto.dart';
import 'package:flutter_template/data/models/user_model.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRemoteDataSource {
  UserRemoteDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  final DioHelper _dioHelper;

  Future<LoginResponseDTO> loginByEmail(LoginByEmailRequestDTO params) async {
    final HttpRequestResponse response = await _dioHelper.post(
      Endpoints.login,
      data: params.toJson(),
    );

    return LoginResponseDTO(
      user: UserModel.fromJson(response.data['data']['user']),
      refreshToken: response.data['data']['token']['refreshToken'],
      accessToken: response.data['data']['token']['accessToken'],
      expiresIn: response.data['data']['token']['expiresIn'],
    );
  }

  Future<void> registerByEmailAndPhoneNumber(RegisterDTO params) async {
    try {
      await _dioHelper.post(Endpoints.register, data: params.toJson());
    } on DioException catch (exception) {
      if (exception.response == null) {
        throw Exception(LocaleKeys.texts_error_occur.tr());
      } else {
        switch (exception.response!.statusCode) {
          case 409:
            throw Exception(LocaleKeys.validator_email_or_phone_number_exists.tr());
          default:
            throw Exception(LocaleKeys.texts_error_occur.tr());
        }
      }
    } 
  }
}
