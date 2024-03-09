import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/models/post_model.dart';

class PostItem extends StatelessWidget {
  final PostModel postModel;
  final AssetImage image;
  const PostItem({
    super.key,
    required this.postModel,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: context.themeConfig.frameAvatarColor,
                radius: 24.0,
                child: CircleAvatar(
                  backgroundImage: image,
                  radius: 22.0,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${postModel.createdAt.day}/${postModel.createdAt.month}/${postModel.createdAt.year} ${postModel.createdAt.hour}:${postModel.createdAt.minute}',
                  ),
                  Text(postModel.author.fullName, style: context.titleSmall),
                  const SizedBox(width: 12.0),
                  Text(
                    postModel.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        // Container(
        //   decoration: BoxDecoration(
        //     color: postModel.tags[0].color,
        //     borderRadius: BorderRadius.circular(24.0),
        //   ),
        //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        //   child: Text(
        //     postModel.tags[0].name,
        //     style: context.titleSmall
        //         .copyWith(color: context.themeConfig.onPrimaryTextColor),
        //   ),
        // ),
      ],
    );
  }
}
