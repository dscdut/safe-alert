import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_template/common/constants/env_keys.dart';
import 'package:flutter_template/generated/firebase_options/firebase_options_dev.dart'
    as firebase_option_dev;
import 'package:flutter_template/generated/firebase_options/firebase_options_prod.dart'
    as firebase_options_prod;
import 'package:flutter_template/generated/firebase_options/firebase_options_staging.dart'
    as firebase_options_staging;

enum Flavor {
  DEV,
  STAGING,
  PROD,
}

class AppFlavor {
  static Flavor? appFlavor;

  static String get apiBaseUrl => const String.fromEnvironment(EnvKeys.baseURL);
  static String get mapsApiKey =>
      const String.fromEnvironment(EnvKeys.mapsApiKey);
  static String get placeAutocompleteURL =>
      const String.fromEnvironment(EnvKeys.placeAutocompleteURL);
  static String get geoCodeURL =>
      const String.fromEnvironment(EnvKeys.geoCodeURL);

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Flutter Template DEV';
      case Flavor.STAGING:
        return 'Flutter Template STAGING';
      case Flavor.PROD:
        return 'Flutter Template';
      default:
        return 'Flutter Template DEV';
    }
  }

  static FirebaseOptions get firebaseOptions {
    return switch (appFlavor) {
      Flavor.DEV => firebase_option_dev.DefaultFirebaseOptions.currentPlatform,
      Flavor.STAGING =>
        firebase_options_staging.DefaultFirebaseOptions.currentPlatform,
      Flavor.PROD =>
        firebase_options_prod.DefaultFirebaseOptions.currentPlatform,
      _ => firebase_option_dev.DefaultFirebaseOptions.currentPlatform,
    };
  }
}
