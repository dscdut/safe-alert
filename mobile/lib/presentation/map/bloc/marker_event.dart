part of 'marker_bloc.dart';

class MarkerEvent {}

class AddNewMarker extends MarkerEvent {
  final Marker marker;
  AddNewMarker(this.marker);
}
