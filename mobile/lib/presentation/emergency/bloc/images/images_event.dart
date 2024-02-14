// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'images_bloc.dart';

class ImagesEvent {}

class UploadNewImageEvent extends ImagesEvent {
  final File newImage;
  UploadNewImageEvent({
    required this.newImage,
  });
}

class GetImagesEvent extends ImagesEvent {}
