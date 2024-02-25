import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/presentation/posts/widgets/new_post/create_post_field.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Create Your New Post',
          style: TextStyle(color: context.themeConfig.onPrimaryTextColor),
        ),
        leading: IconButton(
          color: context.themeConfig.onPrimaryTextColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.clear),
        ),
      ),
      body: const CreatePostField(),
    );
  }
}
