import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_template/common/constants/hive_keys.dart';
import 'package:flutter_template/data/dtos/auth/refresh_token_dto.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

class AppInterceptor extends QueuedInterceptor {
  AppInterceptor({
    @Named(HiveKeys.authBox) required Box authBox,
    required Dio dio,
  })  : _authBox = authBox,
        _dio = dio;

  final Box _authBox;
  final Dio _dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('REQUEST[${options.method}] => PATH: ${options.path}');

    _checkTokenExpired();

    final String? accessToken = _authBox.get(HiveKeys.accessToken);
    // const String? accessToken =
    // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiZW1haWwiOiJjaGF1dGhpQGdtYWlsLmNvbSIsImlhdCI6MTcwODc0MzU1OSwiZXhwIjoxNzA4ODI5OTU5fQ.dscZKZoF_W0nQPnz42JSqDBlkME7qwGD6mDS4eYmvpA';

    if (accessToken != null) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      name: 'Intercepter: onResponse',
    );

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      return;
    }

    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      name: 'Intercepter: onError',
    );

    return handler.next(err);
  }

  Future<void> _checkTokenExpired() async {
    final String? expiredTime = _authBox.get(HiveKeys.expiresIn);

    if (expiredTime != null &&
        DateTime.parse(expiredTime)
            .isBefore(DateTime.now().add(const Duration(seconds: 3)))) {
      await _refreshToken();
    }
  }

  Future<void> _refreshToken() async {
    final String? refreshToken = _authBox.get(HiveKeys.refreshToken);

    if (refreshToken == null || refreshToken.isEmpty) {
      return;
    }

    log('--[REFRESH TOKEN]--: $refreshToken');

    try {
      final Response response = await _dio.get('');

      final RefreshTokenDTO refreshTokenDTO =
          RefreshTokenDTO.fromJson(response.data);

      await _authBox.putAll(refreshTokenDTO.toLocalJson());
      // ignore: empty_catches
    } catch (err) {}
  }
}
