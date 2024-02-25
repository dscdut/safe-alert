// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_case_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyCaseDTO _$EmergencyCaseDTOFromJson(Map<String, dynamic> json) =>
    EmergencyCaseDTO(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      location: json['location'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      emergencyId: json['emergencyId'] as int,
      image: json['image'] as List<dynamic>?,
    );

Map<String, dynamic> _$EmergencyCaseDTOToJson(EmergencyCaseDTO instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
      'description': instance.description,
      'quantity': instance.quantity,
      'emergencyId': instance.emergencyId,
      'image': instance.image,
    };
