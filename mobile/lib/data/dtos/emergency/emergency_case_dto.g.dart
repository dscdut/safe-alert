// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_case_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyCaseDTO _$EmergencyCaseDTOFromJson(Map<String, dynamic> json) =>
    EmergencyCaseDTO(
      latitude: (json['latitude'] as num).toDouble(),
      longtitude: (json['longtitude'] as num).toDouble(),
      location: json['location'] as String,
      quantity: json['quantity'] as int,
      typeOfSituation: json['typeOfSituation'] as int,
      caseDetail: json['caseDetail'] as String,
      images: json['images'],
    );

Map<String, dynamic> _$EmergencyCaseDTOToJson(EmergencyCaseDTO instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longtitude': instance.longtitude,
      'location': instance.location,
      'quantity': instance.quantity,
      'typeOfSituation': instance.typeOfSituation,
      'caseDetail': instance.caseDetail,
      'images': instance.images,
    };
