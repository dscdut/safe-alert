import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/constants/status.dart';
import 'package:flutter_template/presentation/auth/auth.dart';
import 'package:flutter_template/presentation/emergency/bloc/manage/manage_emergency_case_bloc.dart';
import 'package:flutter_template/presentation/home/widgets/app_bar.dart';
import 'package:flutter_template/presentation/map/bloc/position_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_template/data/models/place_model.dart';
import 'package:flutter_template/presentation/emergency/widgets/location_search/location_search.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PositionBloc(
        context.read<ManageEmergencyCaseBloc>(),
        context.read<AuthBloc>(),
      ),
      child: const MapView(),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({
    Key? key,
  }) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _locationController = TextEditingController();

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
      body: BlocBuilder<PositionBloc, PositionState>(
        builder: (context, state) {
          log(state.status.name);
          if (state.status == Status.isLoading ||
              state.status == Status.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state.status == Status.isSuccess) {
              LatLng currentView =
                  context.watch<PositionBloc>().state.currentView;
              List<Marker> markers =
                  context.watch<PositionBloc>().state.markers;
              return GoogleMap(
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: currentView,
                  zoom: 11,
                ),
                myLocationEnabled: true,
                markers: {
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: currentView,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue,
                    ),
                  ),
                  ...markers,
                },
              );
            } else {
              return Center(
                child: Text(state.errorMessage),
              );
            }
          }
        },
      ),
    );
  }
}
