import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/data/models/place_model.dart';
import 'package:flutter_template/data/repositories/place_repository.dart';

part 'place_search_event.dart';
part 'place_search_state.dart';

class PlaceSearchBloc extends Bloc<PlaceSearchEvent, PlaceSearchState> {
  final PlaceRepository _placeRepository;

  PlaceSearchBloc(this._placeRepository) : super(const PlaceSearchState()) {
    on<GetSuggestions>(_onGetSuggestions);
  }

  Future<PlaceModel> _onMapPlaceIDToLocation(PlaceModel placeModel) async {
    final currentLocation =
        await _placeRepository.placeIDToLocation(placeModel.place_id!);
    log(currentLocation.toString());
    return placeModel.copyWith(coordinates: currentLocation);
  }

  Future<void> _onGetSuggestions(
    GetSuggestions event,
    Emitter<PlaceSearchState> emit,
  ) async {
    try {
      if (event.input == null) {
        emit(state.copyWith(suggestions: []));
        return;
      }
      emit(state.copyWith(isLoading: true));
      final suggestions = await _placeRepository.getSuggestions(event.input!);
      final suggestionsWithLocation = await Future.wait(
        suggestions.map((e) => _onMapPlaceIDToLocation(e)),
      );
      log(suggestionsWithLocation.toString());
      emit(
        state.copyWith(isLoading: false, suggestions: suggestionsWithLocation),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
