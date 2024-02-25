import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/data/datasources/user/user_mock.dart';
import 'package:flutter_template/data/models/post_model.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:path_provider/path_provider.dart';

part 'post_event.dart';
part 'post_state.dart';

List<PostModel> modelPosts = [
  PostModel(
    createdAt: DateTime(2024, 2, 16, 17, 30),
    author: users[1],
    authorAvatar: AssetImage(Assets.images.demo.avatar.images1.path),
    description:
        'We provide food packages to those in our neighbourhood who can’t afford to buy food, giving people simple and nutritious food when they need it most. The boxes feature healthy essentials, with plenty of fresh produce, wholefood ingredients and store cupboard ingredients. We combine bulk orders of essentials with food donations from Food Bank AID, The Felix Project, City Harvest and other local partners. The boxes feature healthy essentials, enough food for 3-4 days meals\nIf you would like to enquire about The ARC Food Bank please call Asha on 07727157138 or email on asha@arccollective.co',
    tags: [existingTags[0], existingTags[3]],
  ),
  PostModel(
    createdAt: DateTime(2024, 2, 16, 16, 03),
    author: users[2],
    description:
        'During the past several weeks, the central and Central Highlands of Vietnam has been suffering from heavy rains, floods, and landslides which were caused by the seasonal monsoon combined with a cold spell from the north and the intertropical convergence zone.\n'
        'Most impacted provinces are Thua Thien-Hue, Quang Tri and Quang Nam. The floods are predicted to worsen as rains continue. Military and police personnel were dispatched yesterday afternoon to aid the evacuation of residents in Quang Binh and Ha Tinh provinces which are also facing the rising tides.'
        '\nRed Cross disaster teams are already working alongside local authorities to provide relief assistance. Donations and aids are streaming in from the Vietnam Fatherland Front Central Committee, the IFRC as well as public and private entities'
        'With the motto "We help where we can".\nEvery year, TRG makes sure to reserve funds dedicated to supporting various charitable initiatives and programs across the country. For close to a decade, our CSR team has donated, supported, and visited multiple orphanages, needed families, and unfortunate rural communities suffered from natural disasters.'
        'We are calling for donations to help the people in the Central region of Vietnam. Your support will help us provide food, clean water, and shelter to those affected by the floods. Please donate to our bank account: 1234567890',
    tags: [existingTags[3], existingTags[4]],
    authorAvatar: AssetImage(Assets.images.demo.avatar.images2.path),
  ),
  PostModel(
    createdAt: DateTime(2024, 2, 16, 8, 25),
    author: users[3],
    authorAvatar: AssetImage(Assets.images.demo.avatar.images2.path),
    description:
        'Ealing Soup Kitchen is a charity that seeks to help anyone who needs hot, nutritious food & a helping hand.\n'
        'We’ve been running a weekend Soup Kitchen since 1973 at St John’s Church in Ealing for the homeless, vulnerable, and impoverished. We also run Monday & Friday drop-ins where we provide clothes, food, a barber, showers, foot care, practical help, and games',
    tags: [existingTags[3], existingTags[4]],
  ),
];

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load(path);

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState(posts: modelPosts)) {
    on<UploadNewPost>(_uploadNewPost);
    // on<GetAllPosts>(_getAllPosts);
    // on<GetYourHistoryPosts>(_getYourHistoryPosts);
  }

  void _uploadNewPost(UploadNewPost event, Emitter<PostState> emit) {
    emit(state.copyWith(posts: [event.newPost, ...state.posts]));
  }
}
