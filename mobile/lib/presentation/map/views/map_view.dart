import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_template/data/models/emergency_case_model.dart';
import 'package:flutter_template/presentation/home/widgets/app_bar.dart';
import 'package:flutter_template/presentation/map/get_markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_template/data/models/place_model.dart';
import 'package:flutter_template/presentation/emergency/widgets/location_search/location_search.dart';

class MapView extends StatefulWidget {
  final List<EmergencyCaseModel>? emergencyCases;
  const MapView({
    Key? key,
    this.emergencyCases,
  }) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final LatLng _currentView = const LatLng(16.0722987197085, 108.1484826197085);
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _locationController = TextEditingController();
  List<Marker> _markers = [];

  Future<void> _loadMarkers() async {
    _markers = await GetMarkers(widget.emergencyCases).getMarkers();
  }

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _showSearchScreen() async {
    PlaceModel? choosenPlace = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LocationSearchPage()),
    );
    if (choosenPlace != null) {
      _locationController.text = choosenPlace.description;
      moveCamera(
        LatLng(
          choosenPlace.coordinates!['lat']!,
          choosenPlace.coordinates!['lng']!,
        ),
      );
    }
  }

  Future<void> moveCamera(LatLng newCameraPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: newCameraPosition, zoom: 13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: MyAppBar(onTap: _showSearchScreen),
      body: GoogleMap(
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: _currentView,
          zoom: 13,
        ),
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId('test'),
            position: _currentView,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
          ),
          ..._markers,
        },
      ),
    );
  }
}
