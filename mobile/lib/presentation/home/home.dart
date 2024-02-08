import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/presentation/emergency/views/emergency_post_view.dart';
import 'package:flutter_template/presentation/home/widgets/navigation_bar.dart';
import 'package:flutter_template/presentation/map/views/map_view.dart';
import 'package:flutter_template/presentation/notification/notification.dart';

export 'bloc/home_bloc.dart';
export 'view/home_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget body = const MapView();

  final iconList = [
    Assets.icons.navigationBar.map,
    Assets.icons.navigationBar.post,
  ];
  final selectedIconList = [
    Assets.icons.navigationBar.selectedMap,
    Assets.icons.navigationBar.selectedPost,
  ];
  ValueNotifier<int> activeTab = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: activeTab,
        builder: (context, value, child) {
          return (value == 0) ? const MapView() : const NotificationView();
        },
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNavigationBar(
        onTapBottomBarItem: (int index) {
          activeTab.value = index;
        },
        items: iconList.map((e) => SvgPicture.asset(e.path)).toList(),
        selectedItems:
            selectedIconList.map((e) => SvgPicture.asset(e.path)).toList(),
      ),
      floatingActionButton: IconButton(
        onPressed: _showEmergencyPostSheet,
        icon: SvgPicture.asset(
          Assets.icons.navigationBar.sos.path,
          width: 68,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showEmergencyPostSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => const EmergencyPostView(),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
