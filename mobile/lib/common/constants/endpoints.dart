import 'dart:core';
import 'package:flutter_template/flavors.dart';

abstract class Endpoints {
  static String mapsApiKey = AppFlavor.mapsApiKey;

  static String apiUrl = '${AppFlavor.apiBaseUrl}/api';

  static String login = '$apiUrl/auth';
  static String userInfo = '$apiUrl/auth/me';
  static String register = '$apiUrl/auth/register';
  static String helpSignals = '$apiUrl/helpSignal';
  static String getAllHelpSignals = '$apiUrl/helpSignal/getAllHelpSignals';

  static String placeAutocompleteURL =
      '${AppFlavor.placeAutocompleteURL}/json?key=$mapsApiKey';
  static String geoCodeURL = '${AppFlavor.geoCodeURL}/json?key=$mapsApiKey';
}
