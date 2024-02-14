// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_search_bloc.dart';

class PlaceSearchEvent {}

class GetSuggestions extends PlaceSearchEvent {
  final String? input;
  GetSuggestions({
    this.input,
  });
}
