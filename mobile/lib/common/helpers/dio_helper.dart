import 'dart:io';

import 'package:dio/dio.dart';

class HttpRequestResponse<T> {
  HttpRequestResponse({
    this.data,
    this.headers,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  T? data;
  Headers? headers;
  RequestOptions? request;
  int? statusCode;
  String? statusMessage;
  Map<String, dynamic>? extra;
}

class DioHelper {
  DioHelper({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<HttpRequestResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );

    return HttpRequestResponse(
      data: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  Future<HttpRequestResponse> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? formData,
    Function(int count, int total)? onSendProgress,
  }) async {
    if (formData != null) {
      for (var item in formData.entries) {
        if (item.value is File) {
          formData[item.key] = await MultipartFile.fromFile(item.value.path);
        }
        if (item.value is List<File>) {
          final List<MultipartFile> files = [];
          for (var file in item.value) {
            files.add(await MultipartFile.fromFile(file.path));
          }
          formData[item.key] = files;
        }
      }
      data = FormData.fromMap(formData);
    }

    final Response response = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      options: options,
    );

    return HttpRequestResponse(
      data: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  Future<HttpRequestResponse> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? formData,
  }) async {
    final Response response = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return HttpRequestResponse(
      data: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  Future<HttpRequestResponse> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response response = await _dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return HttpRequestResponse(
      data: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }
}
