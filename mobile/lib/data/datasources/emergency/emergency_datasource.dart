import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/helpers/dio_helper.dart';
import 'package:flutter_template/data/dtos/emergency/emergency_case_dto.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EmergencyDataSource {
  EmergencyDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  final DioHelper _dioHelper;

  Future<List<EmergencyCaseDTO>> getEmergencyCases() async {
    try {
      final HttpRequestResponse response =
          await _dioHelper.get(Endpoints.helpSignals);
      return (response.data as List)
          .map((e) => EmergencyCaseDTO.fromJson(e))
          .toList();
    } catch (exception) {
      throw Exception(LocaleKeys.texts_error_occur.tr());
    }
  }

  Future<void> postEmergencyCase(EmergencyCaseDTO params) async {
    try {
      await _dioHelper.post(Endpoints.helpSignals, formData: params.toJson());
    } on DioException catch (exception) {
      if (exception.response == null) {
        log(exception.error.toString());
        throw Exception(exception.error.toString());
      } else {
        log(exception.response!.statusMessage!);
        switch (exception.response!.statusCode) {
          case 400:
            throw Exception(
              LocaleKeys.validator_field_required.tr(),
            );
          default:
            throw Exception(exception.error.toString());
        }
      }
    }
  }
}
