import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/common/constants/status.dart';
import 'package:flutter_template/data/models/emergency_case_model.dart';
import 'package:flutter_template/data/repositories/emergency_repository.dart';

part 'manage_emergency_case_event.dart';
part 'manage_emergency_case_state.dart';

class ManageEmergencyCaseBloc
    extends Bloc<ManageEmergencyCaseEvent, ManageEmergencyCaseState> {
  final EmergencyRepository _emergencyRepository;

  ManageEmergencyCaseBloc(this._emergencyRepository)
      : super(const ManageEmergencyCaseState()) {
    on<GetEmergencyCasesEvent>(_onGetEmergencyCases);
    add(GetEmergencyCasesEvent());
  }

  Future<void> _onGetEmergencyCases(
    GetEmergencyCasesEvent event,
    Emitter<ManageEmergencyCaseState> emit,
  ) async {
    try {
      log('hello');
      emit(state.copyWith(status: Status.isLoading));
      final response = await _emergencyRepository.getEmergencyCases();
      emit(
        state.copyWith(
          status: Status.isSuccess,
          emergencyCases: response,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
