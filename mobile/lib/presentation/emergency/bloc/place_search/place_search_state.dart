// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_search_bloc.dart';

class PlaceSearchState extends Equatable {
  final List<PlaceModel> suggestions;
  final bool isLoading;
  final String errorMessage;
  const PlaceSearchState({
    this.suggestions = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [suggestions, isLoading, errorMessage];

  PlaceSearchState copyWith({
    List<PlaceModel>? suggestions,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PlaceSearchState(
      suggestions: suggestions ?? this.suggestions,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
