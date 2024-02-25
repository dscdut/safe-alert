import 'dart:convert';

import 'package:flutter_template/common/constants/hive_keys.dart';
import 'package:flutter_template/data/dtos/auth/login_response_dto.dart';
import 'package:flutter_template/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserLocalDataSource {
  UserLocalDataSource({
    @Named(HiveKeys.authBox) required Box authBox,
  }) : _authBox = authBox;

  final Box _authBox;

  UserModel? getUserInfo() {
    final String? rawData = _authBox.get(HiveKeys.user);

    if (rawData == null) {
      return null;
    } else {
      return UserModel.fromJson(Map<String, dynamic>.from(jsonDecode(rawData)));
    }
  }

  Future<void> setUserInfo(UserModel user) async {
    await _authBox.put(HiveKeys.user, jsonEncode(user));
  }

  Future<void> setUserAuth(LoginResponseDTO? response) async {
    if (response == null) {
      await _authBox.clear();
    } else {
      await _authBox.putAll({
        HiveKeys.user: jsonEncode(response.user),
        HiveKeys.accessToken: response.accessToken,
      });
    }
  }
}
