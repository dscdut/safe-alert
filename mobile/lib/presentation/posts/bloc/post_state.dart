// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

class PostState extends Equatable {
  final List<PostModel> posts;
  const PostState({
    this.posts = const [],
  });

  @override
  List<Object> get props => [posts];

  PostState copyWith({
    List<PostModel>? posts,
  }) {
    return PostState(
      posts: posts ?? this.posts,
    );
  }
}
