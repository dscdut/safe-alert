// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/presentation/emergency/bloc/images/images_bloc.dart';

class ImageInputPage extends StatelessWidget {
  final void Function(List<File>?) getImages;
  const ImageInputPage({Key? key, required this.getImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagesBloc(),
      child: ImageInputView(
        getImages: getImages,
      ),
    );
  }
}

class ImageInputView extends StatelessWidget {
  final void Function(List<File>?) getImages;
  const ImageInputView({Key? key, required this.getImages}) : super(key: key);

  void _takePicture(BuildContext context) async {
    final imagePicker = ImagePicker();
    try {
      final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
        imageQuality: 100,
      );

      if (pickedImage == null) {
        return;
      } else {
        if (context.mounted) {
          context
              .read<ImagesBloc>()
              .add(UploadNewImageEvent(newImage: File(pickedImage.path)));
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Upload Images: ',
              style: context.headlineSmall.copyWith(fontSize: 14.0),
            ),
            TextButton.icon(
              onPressed: () {
                _takePicture(context);
              },
              icon: const Icon(Icons.add),
              label: const Text('Upload'),
            ),
          ],
        ),
        BlocBuilder<ImagesBloc, ImagesState>(
          buildWhen: (previous, current) => previous.images != current.images,
          builder: (_, state) {
            var imageFiles = state.images;
            getImages(imageFiles);

            if (imageFiles == null || imageFiles.isEmpty) {
              return const SizedBox.shrink();
            } else {
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageFiles.length,
                  itemBuilder: (_, index) {
                    log('imageFiles: $imageFiles');

                    return Image.file(
                      imageFiles[index],
                      fit: BoxFit.cover,
                    );
                  },
                  separatorBuilder: (_, index) => const SizedBox(width: 12.0),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
