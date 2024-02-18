// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/presentation/home/widgets/app_bar.dart';
import 'package:flutter_template/presentation/map/bloc/marker_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/models/place_model.dart';
import 'package:flutter_template/presentation/emergency/widgets/location_search/location_search.dart';
import 'package:flutter_template/presentation/widgets/common_text_form_field.dart';

class MapView extends StatefulWidget {
  final List<Marker>? markers;
  const MapView({
    Key? key,
    required this.markers,
  }) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final LatLng _currentView = const LatLng(16.0722987197085, 108.1484826197085);
  final Completer<GoogleMapController> _controller = Completer();
  PlaceModel? choosenPlace;
  final _locationController = TextEditingController();

  void _showSearchScreen() async {
    choosenPlace = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LocationSearchPage()),
    );
    if (choosenPlace != null) {
      _locationController.text = choosenPlace!.description!;
      moveCamera(
        LatLng(
          choosenPlace!.location!['lat']!,
          choosenPlace!.location!['lng']!,
        ),
      );
      FocusManager.instance.primaryFocus?.unfocus();
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
          ...?widget.markers,
        },
      ),
    );
  }
}
