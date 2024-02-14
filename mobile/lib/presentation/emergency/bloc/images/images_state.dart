// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'images_bloc.dart';

class ImagesState extends Equatable {
  final List<File>? images;
  const ImagesState(this.images);

  @override
  List<Object> get props => [images as Object];

  ImagesState copyWith({
    List<File>? images,
  }) {
    return ImagesState(
      images ?? this.images,
    );
  }
}
