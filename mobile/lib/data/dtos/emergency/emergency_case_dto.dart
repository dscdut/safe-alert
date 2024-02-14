// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'emergency_case_dto.g.dart';

enum Situation {
  Natural_disaster,
  Fire_disaster,
  Accident,
  Essentials_shelter,
  Vehicle_breakdown
}

@JsonSerializable(createToJson: true)
class EmergencyCaseDTO {
  double latitude;
  double longtitude;
  String location;
  int quantity;
  Situation typeOfSituation;
  String caseDetail;
  dynamic images;
  EmergencyCaseDTO({
    required this.latitude,
    required this.longtitude,
    required this.location,
    required this.quantity,
    required this.typeOfSituation,
    required this.caseDetail,
    this.images,
  });

  factory EmergencyCaseDTO.fromJson(Map<String, dynamic> json) =>
      _$EmergencyCaseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyCaseDTOToJson(this);

  @override
  String toString() {
    return 'EmergencyCaseDTO(latitude: $latitude, longtitude: $longtitude, location: $location, quantity: $quantity, typeOfSituation: $typeOfSituation, caseDetail: $caseDetail, images: $images)';
  }
}
