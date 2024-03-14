import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/datasources/user/user_mock.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:like_button/like_button.dart';

class ReactCommentField extends StatelessWidget {
  const ReactCommentField({
    super.key,
    this.isDetail,
    this.isNew = false,
  });

  final bool? isDetail;
  final bool? isNew;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LikeButton(
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.thumb_up,
                  color: isLiked ? Colors.blue : Colors.grey,
                );
              },
              likeCount: isNew == true ? null : 89,
            ),
            TextButton(
              onPressed: () {},
              child: isNew == true
                  ? const Icon(Icons.comment)
                  : const Text('4 comments'),
            ),
          ],
        ),
        isDetail == true
            ? CommentTreeWidget<Comment, Comment>(
                Comment(
                  avatar: 'null',
                  userName: users[1].fullName,
                  content: 'So meaningful',
                ),
                [
                  Comment(
                    avatar: 'null',
                    userName: users[2].fullName,
                    content: 'What is a greate project',
                  ),
                  Comment(
                    avatar: 'null',
                    userName: users[2].fullName,
                    content: 'How can I join it?',
                  ),
                  Comment(
                    avatar: 'null',
                    userName: users[3].fullName,
                    content: 'I think it is a good idea',
                  ),
                ],
                avatarRoot: (context, data) => PreferredSize(
                  preferredSize: const Size.fromRadius(18),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        AssetImage(Assets.images.demo.avatar.images1.path),
                  ),
                ),
                avatarChild: (context, data) => PreferredSize(
                  preferredSize: const Size.fromRadius(12),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        AssetImage(Assets.images.demo.avatar.images2.path),
                  ),
                ),
                contentChild: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.userName}',
                              style: context.bodySmall,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data.content}',
                              style: context.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text('Like'),
                              SizedBox(
                                width: 24,
                              ),
                              Text('Reply'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                contentRoot: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.userName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data.content}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text('Like'),
                              SizedBox(
                                width: 24,
                              ),
                              Text('Reply'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
