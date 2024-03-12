import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/common/constants/status.dart';
import 'package:flutter_template/data/models/emergency_case_model.dart';
import 'package:flutter_template/data/repositories/emergency_repository.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/presentation/emergency/bloc/manage/manage_emergency_case_bloc.dart';
import 'package:flutter_template/presentation/emergency/views/emergency_post_view.dart';
import 'package:flutter_template/presentation/home/widgets/navigation_bar.dart';
import 'package:flutter_template/presentation/map/views/map_view.dart';
import 'package:flutter_template/presentation/posts/view/posts/post_view.dart';

export '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ManageEmergencyCaseBloc(getIt.get<EmergencyRepository>()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<EmergencyCaseModel> emergencyCases;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final iconList = [
    Assets.icons.navigationBar.map,
    Assets.icons.navigationBar.post,
  ];
  final selectedIconList = [
    Assets.icons.navigationBar.selectedMap,
    Assets.icons.navigationBar.selectedPost,
  ];
  int activeTab = 0;

  @override
  void initState() {
    super.initState();
  }

  // void listenToNewDeviceToken() async {
  //   final firstToken = await messaging.getToken();
  //   if (firstToken != null) {
  //     onPostNewDeviceToken(firstToken);
  //   }
  //   messaging.onTokenRefresh
  //       .listen((newToken) => onPostNewDeviceToken(newToken));
  // }

  // void onPostNewDeviceToken(String token) {
  //   final userID = context.read<AuthBloc>().state.user!.id;
  //   final data = {
  //     'deviceToken': token,
  //   };
  //   db
  //       .collection('deviceToken')
  //       .doc('$userID')
  //       .set(data, SetOptions(merge: true));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: (activeTab == 1)
          ? const PostPage()
          : BlocBuilder<ManageEmergencyCaseBloc, ManageEmergencyCaseState>(
              buildWhen: (previous, current) =>
                  previous.emergencyCases != current.emergencyCases,
              builder: (context, state) {
                if (state.status == Status.isLoading ||
                    state.status == Status.initial) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (state.status == Status.error) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  } else {
                    return const MapPage();
                  }
                }
              },
            ),
      extendBody: true,
      bottomNavigationBar: AnimatedNavigationBar(
        onTapBottomBarItem: (int index) {
          setState(() {
            activeTab = index;
          });
        },
        items: iconList.map((e) => SvgPicture.asset(e.path)).toList(),
        selectedItems:
            selectedIconList.map((e) => SvgPicture.asset(e.path)).toList(),
      ),
      floatingActionButton: IconButton(
        onPressed: _showEmergencyPostSheet,
        icon: SvgPicture.asset(Assets.icons.navigationBar.sos.path, width: 68),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showEmergencyPostSheet() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => const EmergencyPostView(),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ).then(
      (value) => BlocProvider.of<ManageEmergencyCaseBloc>(context)
          .add(GetEmergencyCasesEvent()),
    );
  }
}
