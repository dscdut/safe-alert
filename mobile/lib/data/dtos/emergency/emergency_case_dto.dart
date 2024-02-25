// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'emergency_case_dto.g.dart';

enum Situation {
  Natural_disaster,
  Fire_accident,
  Accident,
  Essentials_shelter,
  Vehicle_breakdown
}

@JsonSerializable(createToJson: true)
class EmergencyCaseDTO {
  double latitude;
  double longitude;
  String location;
  String description;
  int quantity;
  int emergencyId;
  List<dynamic>? image;
  EmergencyCaseDTO({
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.description,
    required this.quantity,
    required this.emergencyId,
    this.image,
  });

  factory EmergencyCaseDTO.fromJson(Map<String, dynamic> json) =>
      _$EmergencyCaseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyCaseDTOToJson(this);

  @override
  String toString() {
    return 'EmergencyCaseDTO(latitude: $latitude, longitude: $longitude, location: $location, description: $description, quantity: $quantity, emergencyId: $emergencyId, image: $image)';
  }
}
