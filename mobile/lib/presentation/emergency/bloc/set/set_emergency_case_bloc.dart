import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/data/dtos/emergency/emergency_case_dto.dart';
import 'package:flutter_template/data/repositories/emergency_repository.dart';

part 'set_emergency_case_event.dart';
part 'set_emergency_case_state.dart';

class SetEmergencyCaseBloc
    extends Bloc<SetEmergencyCaseEvent, SetEmergencyCaseState> {
  final EmergencyRepository _emergencyRepository;

  SetEmergencyCaseBloc(this._emergencyRepository)
      : super(const SetEmergencyCaseState()) {
    on<PostNewEmergencyCaseEvent>(_onPostNewEmergencyCase);
  }

  Future<void> _onPostNewEmergencyCase(
    PostNewEmergencyCaseEvent event,
    Emitter<SetEmergencyCaseState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _emergencyRepository.postEmergencyCase(event.newEmergencyCase);
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          emergencyCases: [...state.emergencyCases, event.newEmergencyCase],
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
