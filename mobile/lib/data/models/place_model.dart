// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable(createToJson: false)
class PlaceModel {
  final String description;
  final String place_id;
  final Map<String, double>? coordinates;

  PlaceModel({
    this.coordinates,
    required this.description,
    required this.place_id,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  @override
  String toString() =>
      'PlaceModel(description: $description, place_id: $place_id, location: $coordinates)';

  PlaceModel copyWith({
    String? description,
    String? place_id,
    Map<String, double>? coordinates,
  }) {
    return PlaceModel(
      description: description ?? this.description,
      place_id: place_id ?? this.place_id,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
