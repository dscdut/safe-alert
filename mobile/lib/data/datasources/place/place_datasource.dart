import 'dart:io';
import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/helpers/dio_helper.dart';
import 'package:flutter_template/data/models/place_model.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlaceDataSource {
  final DioHelper _dioHelper;

  PlaceDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  Future<List<PlaceModel>> getSuggestions(String input) async {
    final String country = Platform.localeName.split('_').first;
    input = input.replaceAll(' ', '+');
    final response = await _dioHelper.get(
      '${Endpoints.placeAutocompleteURL}&input=$input&language=$country',
    );

    if (response.statusCode != 200) {
      throw Exception(LocaleKeys.texts_error_occur);
    }

    final List<PlaceModel> places =
        (response.data['predictions'] as List<dynamic>).map((e) {
      return PlaceModel.fromJson(e);
    }).toList();

    return places;
  }

  Future<Map<String, double>> placeIDToLocation(String placeId) async {
    final response = await _dioHelper.get(
      '${Endpoints.geoCodeURL}&place_id=$placeId',
    );
    if (response.statusCode != 200) {
      throw Exception(LocaleKeys.texts_error_occur);
    }
    final location = response.data['results'][0]['geometry']['location'];
    return {
      'lat': double.parse(
        (location['lat'] as double).toStringAsFixed(10),
      ),
      'lng': double.parse(
        (location['lng'] as double).toStringAsFixed(10),
      ),
    };
  }
}
