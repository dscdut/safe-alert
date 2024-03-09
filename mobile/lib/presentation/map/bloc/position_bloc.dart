import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/common/constants/status.dart';
import 'package:flutter_template/data/models/emergency_case_model.dart';
import 'package:flutter_template/presentation/emergency/bloc/manage/manage_emergency_case_bloc.dart';
import 'package:flutter_template/presentation/map/get_current_location.dart';
import 'package:flutter_template/presentation/map/get_markers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc(this.manageEmergencyCaseBloc) : super(const PositionState()) {
    on<GetPosition>(_onGetPosition);
    on<CurrentPositionChanged>(_onCurrentPositionChanged);
    on<GetMarkersEvent>(_onGetMarkers);
    add(GetPosition());
    add(GetMarkersEvent(manageEmergencyCaseBloc.state.emergencyCases));
    positionSubscription = RealtimePosition.positionStream
        .listen((position) => add(CurrentPositionChanged(position)));

    emergencyCasesSubscription = manageEmergencyCaseBloc.stream
        .listen((cases) => add(GetMarkersEvent(cases.emergencyCases)));
  }

  final ManageEmergencyCaseBloc manageEmergencyCaseBloc;
  late StreamSubscription emergencyCasesSubscription;
  late StreamSubscription<Position> positionSubscription;

  @override
  Future<void> close() {
    positionSubscription.cancel();
    return super.close();
  }

  Future<void> _onGetPosition(
    GetPosition event,
    Emitter<PositionState> emit,
  ) async {
    emit(state.copyWith(status: Status.isLoading));
    try {
      Position position = await RealtimePosition.determinePosition();
      emit(
        state.copyWith(
          status: Status.isSuccess,
          currentView: LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
    }
  }

  void _onCurrentPositionChanged(
    CurrentPositionChanged event,
    Emitter<PositionState> emit,
  ) {
    emit(
      state.copyWith(
        status: Status.isSuccess,
        currentView: LatLng(event.position.latitude, event.position.longitude),
      ),
    );
  }

  Future<void> _onGetMarkers(
    GetMarkersEvent event,
    Emitter<PositionState> emit,
  ) async {
    try {
      List<Marker> markers =
          await GetMarkers(event.emergencyCases).getMarkers();
      emit(
        state.copyWith(
          status: Status.isSuccess,
          markers: markers,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
    }
  }
}
