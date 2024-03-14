import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/models/post_model.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/presentation/posts/widgets/react_comment/react_comment_field.dart';

class PostDetail extends StatelessWidget {
  final PostModel post;
  const PostDetail({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: context.themeConfig.frameAvatarColor,
                  radius: 30.0,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage(Assets.icons.launcher.appIcon.path),
                    radius: 28.0,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.author.fullName,
                            style: context.headlineSmall.copyWith(fontSize: 14),
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            '${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year} ${post.createdAt.hour}:${post.createdAt.minute}',
                            style: context.bodySmall,
                          ),
                        ],
                      ),
                      Text(
                        post.location,
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
                                color: post.tags[index].color,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                post.tags[index].name,
                                style: context.titleSmall.copyWith(
                                  color: context.themeConfig.onPrimaryTextColor,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 8.0,
                          ),
                          itemCount: post.tags.length,
                        ),
                      ),
                    ],
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       '${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}',
                //     ),
                //     Text(post.author.fullName, style: context.titleSmall),
                //   ],
                // ),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(post.description),
                      ),
                      const SizedBox(height: 12.0),
                      (post.images != null)
                          ? Center(
                              child: SizedBox(
                                height: 400.0,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) =>
                                      Image.file(post.images![index]),
                                  separatorBuilder: (_, indedx) =>
                                      const SizedBox.expand(),
                                  itemCount: (post.images as List<File>).length,
                                  shrinkWrap: true,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      const ReactCommentField(isDetail: true),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
