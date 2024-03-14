enum ReactableType {
  POST,
  COMMENT,
}

enum ReactType {
  LIKE,
  DISLIKE,
}

class ReactModel {
  final int reactableId;
  final ReactableType reactableType;
  final ReactType reactType;

  ReactModel({
    required this.reactableId,
    required this.reactableType,
    required this.reactType,
  });
}
