// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

class PostEvent {}

class UploadNewPost extends PostEvent {
  final PostModel newPost;
  UploadNewPost({
    required this.newPost,
  });
}

class GetAllPosts extends PostEvent {}

class GetYourHistoryPosts extends PostEvent {}
