import 'package:flutter_template/data/dtos/emergency/emergency_case_dto.dart';
import 'package:flutter_template/data/models/emergency_case_model.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_template/data/datasources/emergency/emergency_datasource.dart';

@LazySingleton()
class EmergencyRepository {
  final EmergencyDataSource dataSource;
  EmergencyRepository({
    required this.dataSource,
  });
  Future<void> postEmergencyCase(EmergencyCaseDTO params) {
    return dataSource.postEmergencyCase(params);
  }

  Future<List<EmergencyCaseModel>> getEmergencyCases() {
    return dataSource.getEmergencyCases();
  }
}
