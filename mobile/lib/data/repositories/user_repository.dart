import 'package:flutter_template/data/datasources/user/user_datasource.dart';
import 'package:flutter_template/data/dtos/auth/login_by_email_request_dto.dart';
import 'package:flutter_template/data/dtos/auth/register_response_dto.dart';
import 'package:flutter_template/data/dtos/auth/login_by_phone_number_request_dto.dart';
import 'package:flutter_template/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  UserRepository({
    required UserDataSource dataSource,
  }) : _dataSource = dataSource;

  final UserDataSource _dataSource;

  Future<UserModel> loginByEmail(LoginByEmailRequestDTO params) {
    return _dataSource.loginByEmail(params);
  }

  Future<UserModel> loginByPhoneNumber(LoginByPhoneNumberRequestDTO params) {
    return _dataSource.loginByPhoneNumber(params);
  }

  UserModel? getUserInfo() {
    return _dataSource.getUserInfo();
  }

  Future<void> registerByEmailAndPhoneNumber(RegisterDTO params) {
    return _dataSource.registerByEmailAndPhoneNumber(params);
  }
}
