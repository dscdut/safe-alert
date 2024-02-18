import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class AnimatedNavigationBar extends StatefulWidget {
  final void Function(int) onTapBottomBarItem;
  final List<Widget> items;
  final List<Widget> selectedItems;

  const AnimatedNavigationBar({
    Key? key,
    required this.onTapBottomBarItem,
    required this.items,
    required this.selectedItems,
  }) : super(key: key);

  @override
  State<AnimatedNavigationBar> createState() => _AnimatedNavigationBarState();
}

class _AnimatedNavigationBarState extends State<AnimatedNavigationBar> {
  var activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      height: 72,
      notchSmoothness: NotchSmoothness.softEdge,
      gapLocation: GapLocation.center,
      onTap: (index) {
        widget.onTapBottomBarItem(index);
        setState(() {
          activeIndex = index;
        });
      },
      itemCount: 2,
      tabBuilder: (index, isActive) {
        return Container(
          padding: const EdgeInsets.all(12.0),
          child: isActive ? widget.selectedItems[index] : widget.items[index],
        );
      },
      activeIndex: activeIndex,
      shadow: const BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 12,
        spreadRadius: 0.5,
        color: Colors.black45,
      ),
      leftCornerRadius: 32,
      rightCornerRadius: 32,
    );
  }
}
