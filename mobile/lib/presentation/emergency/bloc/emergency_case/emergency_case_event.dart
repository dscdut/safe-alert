part of 'emergency_case_bloc.dart';

class EmergencyCaseEvent {}

class GetEmergencyCasesEvent extends EmergencyCaseEvent {}

class PostNewEmergencyCaseEvent extends EmergencyCaseEvent {
  final EmergencyCaseDTO newEmergencyCase;

  PostNewEmergencyCaseEvent(this.newEmergencyCase);
}
