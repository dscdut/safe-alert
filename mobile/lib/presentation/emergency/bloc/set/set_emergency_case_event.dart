part of 'set_emergency_case_bloc.dart';

class SetEmergencyCaseEvent {}

class PostNewEmergencyCaseEvent extends SetEmergencyCaseEvent {
  final EmergencyCaseDTO newEmergencyCase;

  PostNewEmergencyCaseEvent(this.newEmergencyCase);
}
