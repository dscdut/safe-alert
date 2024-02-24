import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/models/post_model.dart';
import 'package:flutter_template/presentation/posts/bloc/post_bloc.dart';
import 'package:flutter_template/presentation/posts/view/new_post/create_post_view.dart';
import 'package:flutter_template/presentation/posts/widgets/post/post_detail.dart';
import 'package:flutter_template/presentation/posts/widgets/post/post_item.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(),
      child: const PostView(),
    );
  }
}

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  Color? _historyBackgroundColor;
  Color? _historyTextColor;
  Color? _allPostsbackgroundColor;
  Color? _allPostsTextColor;
  List<PostModel> _postList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Posts', style: context.titleSmall.copyWith(fontSize: 28.0)),
              Row(
                children: [
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<PostBloc>(context),
                              child: const CreatePostView(),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _onTapAllPosts,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _historyBackgroundColor,
                      foregroundColor: _historyTextColor,
                    ),
                    child: const Text('All Posts'),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _onTapYourHistory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _allPostsbackgroundColor,
                      foregroundColor: _allPostsTextColor,
                    ),
                    child: const Text('Your History'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Flexible(
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    _postList = context.watch<PostBloc>().state.posts;
                    log(_postList.length.toString());
                    return ListView.separated(
                      itemCount: _postList.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _showPostDetail(_postList[index]);
                          },
                          child: PostItem(
                            postModel: _postList[index],
                            image: _postList[index].authorAvatar,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const Divider(
                          thickness: 0.0,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapAllPosts() {
    setState(() {
      if (_historyBackgroundColor == null) {
        _historyBackgroundColor = context.themeConfig.primaryColor;
        _historyTextColor = context.themeConfig.onPrimaryTextColor;
        _allPostsbackgroundColor = null;
        _allPostsTextColor = null;
        // _postList = allPosts;
      }
    });
  }

  void _onTapYourHistory() {
    setState(() {
      if (_allPostsbackgroundColor == null) {
        _allPostsbackgroundColor = context.themeConfig.primaryColor;
        _allPostsTextColor = context.themeConfig.onPrimaryTextColor;
        _historyBackgroundColor = null;
        _historyTextColor = null;
        // _postList = yourHistoryPosts;
      }
    });
  }

  void _showPostDetail(PostModel postModel) {
    showModalBottomSheet(
      context: context,
      builder: (_) => PostDetail(post: postModel),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
