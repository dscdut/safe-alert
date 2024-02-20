import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/data/dtos/emergency/emergency_case_dto.dart';
import 'package:flutter_template/data/repositories/emergency_repository.dart';

part 'emergency_case_event.dart';
part 'emergency_case_state.dart';

class EmergencyCaseBloc extends Bloc<EmergencyCaseEvent, EmergencyCaseState> {
  final EmergencyRepository _emergencyRepository;

  EmergencyCaseBloc(this._emergencyRepository)
      : super(const EmergencyCaseState()) {
    on<PostNewEmergencyCaseEvent>(_onPostNewEmergencyCase);
    on<GetEmergencyCasesEvent>(_onGetEmergencyCases);
  }

  Future<void> _onPostNewEmergencyCase(
    PostNewEmergencyCaseEvent event,
    Emitter<EmergencyCaseState> emit,
  ) async {
    try {
      await _emergencyRepository.postEmergencyCase(event.newEmergencyCase);
      emit(
        state.copyWith(
          isSuccess: true,
          emergencyCases: [...state.emergencyCases, event.newEmergencyCase],
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(isSuccess: false, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onGetEmergencyCases(
    GetEmergencyCasesEvent event,
    Emitter<EmergencyCaseState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _emergencyRepository.getEmergencyCases();
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          emergencyCases: [...state.emergencyCases],
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
