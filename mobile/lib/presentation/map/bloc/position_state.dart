// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'position_bloc.dart';

class PositionState extends Equatable {
  final LatLng currentView;
  final List<Marker> markers;
  final Status status;
  final String errorMessage;

  const PositionState({
    this.currentView = const LatLng(0, 0),
    this.markers = const [],
    this.status = Status.initial,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [currentView, markers, status, errorMessage];

  PositionState copyWith({
    LatLng? currentView,
    List<Marker>? markers,
    Status? status,
    String? errorMessage,
  }) {
    return PositionState(
      currentView: currentView ?? this.currentView,
      markers: markers ?? this.markers,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
