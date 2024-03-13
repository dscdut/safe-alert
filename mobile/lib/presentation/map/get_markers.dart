import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/widget_to_map_icon.dart';
import 'package:flutter_template/data/models/emergency_case_model.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetMarkers {
  final List<EmergencyCaseModel>? emergencyCases;
  GetMarkers(
    this.emergencyCases,
  );

  Future<BitmapDescriptor> getCustomIcon() async {
    return SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(Assets.icons.emergency.alert.path),
    ).toBitmapDescriptor();
  }

  Future<List<Marker>> getMarkers() async {
    BitmapDescriptor icon = await getCustomIcon();
    return emergencyCases?.map((emergencyCase) {
          return Marker(
            markerId: MarkerId(emergencyCase.id.toString()),
            position: LatLng(
              emergencyCase.latitude,
              emergencyCase.longitude,
            ),
            icon: icon,
            anchor: const Offset(0.5, 0.5),
          );
        }).toList() ??
        [];
  }
}
