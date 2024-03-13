part of 'position_bloc.dart';

class PositionEvent {}

class GetPosition extends PositionEvent {}

class CurrentPositionChanged extends PositionEvent {
  final Position position;

  CurrentPositionChanged(this.position);
}

class GetMarkersEvent extends PositionEvent {
  final List<EmergencyCaseModel> emergencyCases;

  GetMarkersEvent(this.emergencyCases);
}
