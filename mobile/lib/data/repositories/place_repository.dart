// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_template/data/datasources/place/place_datasource.dart';
import 'package:flutter_template/data/models/place_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlaceRepository {
  final PlaceDataSource placeDataSource;
  PlaceRepository({
    required this.placeDataSource,
  });

  Future<List<PlaceModel>> getSuggestions(String input) {
    return placeDataSource.getSuggestions(input);
  }

  Future<Map<String, double>> placeIDToLocation(String placeId) {
    return placeDataSource.placeIDToLocation(placeId);
  }
}
