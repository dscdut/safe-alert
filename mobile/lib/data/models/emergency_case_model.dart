// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'emergency_case_model.g.dart';

// Entity
@JsonSerializable(explicitToJson: true)
class EmergencyCaseModel {
  int id;
  double latitude;
  double longitude;
  String location;
  String description;
  int quantity;
  dynamic images;
  int status_id;
  int user_id;
  int emergency_id;
  String type;
  String phoneNumber;
  String fullName;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  EmergencyCaseModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.description,
    required this.quantity,
    this.images,
    required this.status_id,
    required this.user_id,
    required this.emergency_id,
    required this.type,
    required this.phoneNumber,
    required this.fullName,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory EmergencyCaseModel.fromJson(Map<String, dynamic> json) =>
      _$EmergencyCaseModelFromJson(json);

  @override
  String toString() {
    return 'EmergencyCaseModel(id: $id, latitude: $latitude, longitude: $longitude, location: $location, description: $description, quantity: $quantity, images: $images, status_id: $status_id, user_id: $user_id, emergency_id: $emergency_id, type: $type, phoneNumber: $phoneNumber, fullName: $fullName, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }
}
