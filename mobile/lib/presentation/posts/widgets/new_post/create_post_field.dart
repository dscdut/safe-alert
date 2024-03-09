import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/datasources/user/user_mock.dart';
import 'package:flutter_template/data/models/post_model.dart';
import 'package:flutter_template/data/models/user_model.dart';
import 'package:flutter_template/presentation/emergency/widgets/images_upload/images_input.dart';
import 'package:flutter_template/presentation/posts/bloc/post_bloc.dart';
import 'package:flutter_template/presentation/posts/widgets/new_post/tags_selection.dart';
import 'package:flutter_template/presentation/widgets/common_alert_dialog.dart';
import 'package:flutter_template/presentation/widgets/common_rounded_button.dart';

class CreatePostField extends StatefulWidget {
  const CreatePostField({super.key});

  @override
  State<CreatePostField> createState() => _CreatePostFieldState();
}

class _CreatePostFieldState extends State<CreatePostField> {
  final DateTime date = DateTime.now();
  final UserModel author = users[0];
  final _postContentController = TextEditingController();
  final AssetImage authorAvatar = demoAvater;
  List<File>? images = [];
  List<PostTag> tags = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: context.themeConfig.frameAvatarColor,
                radius: 30.0,
                child: CircleAvatar(
                  backgroundImage: authorAvatar,
                  radius: 28.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                author.fullName,
                style: context.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'How could you help your community?',
                      style: context.headlineSmall.copyWith(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _postContentController,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    minLines: 5,
                    maxLines: 10,
                    maxLength: 500,
                    keyboardType: TextInputType.multiline,
                  ),
                  TagsSelection(
                    updateTagsSelection: (value) {
                      tags = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ImageInputPage(
                    getImages: (value) {
                      images = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: CommonRoundedButton(
                      onPressed: _uploadNewPost,
                      content: 'Post',
                      borderRadius: 16.0,
                      backgroundColor:
                          context.themeConfig.buttonBackGroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _uploadNewPost() async {
    final newPost = PostModel(
      createdAt: date,
      author: author,
      authorAvatar: authorAvatar,
      description: _postContentController.text,
      tags: tags,
    );

    BlocProvider.of<PostBloc>(context).add(UploadNewPost(newPost: newPost));
    await showDialog(
      context: context,
      builder: (_) => const CommonAlertDialog(
        title: 'Post uploaded',
        content: 'Your post has been posted successfully!',
      ),
    );
  }
}
