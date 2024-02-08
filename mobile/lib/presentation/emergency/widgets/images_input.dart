// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/presentation/emergency/bloc/images_bloc.dart';
import 'package:image_picker/image_picker.dart';

// class ImageInputArea extends StatelessWidget {
//   const ImageInputArea({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ImagesBloc(),
//       child: ImageInput(),
//     );
//   }
// }

class ImageInput extends StatelessWidget {
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
      throw Exception('Fail to access your photo library');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Upload Images/Videos: ',
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
          builder: (context, state) {
            var imageFiles = context.watch<ImagesBloc>().state.images;
            if (imageFiles == null || imageFiles.isEmpty) {
              return const SizedBox.shrink();
            } else {
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageFiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      imageFiles[index],
                      fit: BoxFit.cover,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 12.0),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
