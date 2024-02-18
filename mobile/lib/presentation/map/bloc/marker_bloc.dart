import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/widget_to_map_icon.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'marker_event.dart';
part 'marker_state.dart';

class MarkerBloc extends Bloc<MarkerEvent, MarkerState> {
  MarkerBloc() : super(const MarkerState()) {
    on<AddNewMarker>(_addNewMarker);
  }

  Future<BitmapDescriptor> getCustomIcon() async {
    return SizedBox(
      height: 200,
      width: 200,
      child: Image.asset(Assets.icons.emergency.alert.path),
    ).toBitmapDescriptor();
  }

  void _addNewMarker(AddNewMarker event, Emitter<MarkerState> emit) async {
    emit(
      state.copyWith(
        markers: [
          ...state.markers,
          event.marker.copyWith(iconParam: await getCustomIcon()),
        ],
      ),
    );
  }
}
