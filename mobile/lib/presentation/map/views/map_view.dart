import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final LatLng _center = const LatLng(16.066740, 108.151154);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 14.5,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('test'),
          position: _center,
        ),
      },
    );
  }
}
