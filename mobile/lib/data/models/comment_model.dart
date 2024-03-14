enum CommentParentType {
  POST,
  COMMENT,
}

class CommentModel {
  final int parentId;
  final CommentParentType parentType;
  final String content;

  CommentModel({
    required this.parentId,
    required this.parentType,
    required this.content,
  });
}
