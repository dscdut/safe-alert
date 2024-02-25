import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc() : super(const ImagesState([])) {
    on<GetImagesEvent>(_getImages);
    on<UploadNewImageEvent>(_uploadNewImage);
  }

  void _getImages(GetImagesEvent event, Emitter<ImagesState> emit) {}

  void _uploadNewImage(UploadNewImageEvent event, Emitter<ImagesState> emit) {
    if (state.images != null && state.images!.isEmpty) {
      emit(state.copyWith(images: [...state.images!, event.newImage]));
      log(state.images.toString());
    }
  }
}
