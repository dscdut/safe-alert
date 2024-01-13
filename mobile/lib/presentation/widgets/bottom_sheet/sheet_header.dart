import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';

class SheetHeader extends StatelessWidget {
  final String title;

  const SheetHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            title,
            style: context.titleLarge.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const Divider(
          height: 0,
        ),
      ],
    );
  }
}
