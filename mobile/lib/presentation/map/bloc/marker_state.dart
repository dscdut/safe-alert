// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'marker_bloc.dart';

class MarkerState extends Equatable {
  final List<Marker> markers;
  const MarkerState({this.markers = const []});

  @override
  List<Object> get props => [markers];

  MarkerState copyWith({
    List<Marker>? markers,
  }) {
    return MarkerState(
      markers: markers ?? this.markers,
    );
  }
}
