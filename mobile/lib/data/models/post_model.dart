// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_template/data/models/user_model.dart';
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

final demoAvater = AssetImage(Assets.icons.launcher.appIcon.path);

class PostModel {
  DateTime createdAt;
  UserModel author;
  AssetImage authorAvatar = demoAvater;
  String description;
  List<PostTag> tags;
  List<dynamic>? images = [];
  PostModel({
    required this.createdAt,
    required this.author,
    required this.authorAvatar,
    required this.description,
    required this.tags,
    this.images,
  });

  @override
  String toString() {
    return 'PostModel(createdAt: $createdAt, author: $author, description: $description, tags: $tags, images: $images)';
  }
}
