// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_template/generated/assets.gen.dart';

class PostTag {
  final String name;
  final Color color;
  PostTag({
    required this.name,
    required this.color,
  });
}

final List<PostTag> existingTags = [
  PostTag(name: 'Food', color: Colors.red),
  PostTag(name: 'Accomodation', color: Colors.blue),
  PostTag(name: 'Transportation', color: Colors.green),
  PostTag(name: 'Necessity', color: Colors.purple),
  PostTag(name: 'Other', color: Colors.yellow),
];

final List<AssetImage> avatar = [
  AssetImage(Assets.images.demo.avatar.images1.path),
  AssetImage(Assets.images.demo.avatar.images2.path),
  AssetImage(Assets.images.demo.avatar.images4.path),
  AssetImage(Assets.images.demo.avatar.images3.path),
];
final demoAvater = AssetImage(Assets.icons.launcher.appIcon.path);

class PostModel {
  DateTime date;
  String author;
  String description;
  List<PostTag> tags;
  dynamic images;
  PostModel({
    required this.date,
    required this.author,
    required this.description,
    required this.tags,
    required this.images,
  });

  @override
  String toString() {
    return 'PostModel(date: $date, author: $author, description: $description, tags: $tags, images: $images)';
  }
}
