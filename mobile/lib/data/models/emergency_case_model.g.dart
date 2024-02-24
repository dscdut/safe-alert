// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_case_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyCaseModel _$EmergencyCaseModelFromJson(Map<String, dynamic> json) =>
    EmergencyCaseModel(
      id: json['id'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      location: json['location'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      images: json['images'],
      status_id: json['status_id'] as int,
      user_id: json['user_id'] as int,
      emergency_id: json['emergency_id'] as int,
      type: json['type'] as String,
      phoneNumber: json['phoneNumber'] as String,
      fullName: json['fullName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$EmergencyCaseModelToJson(EmergencyCaseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
      'description': instance.description,
      'quantity': instance.quantity,
      'images': instance.images,
      'status_id': instance.status_id,
      'user_id': instance.user_id,
      'emergency_id': instance.emergency_id,
      'type': instance.type,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
