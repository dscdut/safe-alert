import 'package:flutter/material.dart';

class DismissBackground extends StatelessWidget {
  final double radius;

  const DismissBackground({super.key, this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
