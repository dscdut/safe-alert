extension MapExtension on Map {
  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      this[key] = value;
    }
  }
}
