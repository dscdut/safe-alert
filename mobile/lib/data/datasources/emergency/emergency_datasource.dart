import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/helpers/dio_helper.dart';
import 'package:flutter_template/data/dtos/emergency/emergency_case_dto.dart';
import 'package:flutter_template/data/models/emergency_case_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EmergencyDataSource {
  EmergencyDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  final DioHelper _dioHelper;

  Future<List<EmergencyCaseModel>> getEmergencyCases() async {
    try {
      final HttpRequestResponse response =
          await _dioHelper.get(Endpoints.getAllHelpSignals);

      final List<EmergencyCaseModel> emergencyCases = (response.data as List)
          .map((e) => EmergencyCaseModel.fromJson(e))
          .toList();
      log(emergencyCases.toString());
      return emergencyCases;
    } catch (exception) {
      throw Exception(exception.toString());
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
        throw Exception(exception.response!.statusMessage);
      }
    }
  }
}
