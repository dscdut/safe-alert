import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/models/post_model.dart';
import 'package:flutter_template/presentation/posts/widgets/react_comment/react_comment_field.dart';

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
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        postModel.author.fullName,
                        style: context.headlineSmall.copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        '${postModel.createdAt.day}/${postModel.createdAt.month}/${postModel.createdAt.year} ${postModel.createdAt.hour}:${postModel.createdAt.minute}',
                        style: context.bodySmall,
                      ),
                    ],
                  ),
                  Text(
                    postModel.location,
                    style: context.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 20,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, int index) {
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: postModel.tags[index].color,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Text(
                            postModel.tags[index].name,
                            style: context.titleSmall.copyWith(
                              color: context.themeConfig.onPrimaryTextColor,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 8.0,
                      ),
                      itemCount: postModel.tags.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          postModel.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const ReactCommentField(
          isDetail: false,
        ),
      ],
    );
  }
}
