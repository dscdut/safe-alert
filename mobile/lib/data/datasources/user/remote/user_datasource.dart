import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/helpers/dio_helper.dart';
import 'package:flutter_template/data/dtos/auth/login_by_email_request_dto.dart';
import 'package:flutter_template/data/dtos/auth/login_response_dto.dart';
import 'package:flutter_template/data/models/user_model.dart';
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
}
