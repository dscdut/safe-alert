import 'package:flutter/material.dart';
import 'package:flutter_template/presentation/widgets/dismissible/original_dismissible.dart' as common;
import 'package:flutter_template/presentation/widgets/dismissible/dismiss_background.dart';

class CommonDismissible extends StatelessWidget {
  final Key valueKey;
  final bool hasDismiss;
  final void Function()? onDismissed;
  final Widget child;
  final double radius;

  const CommonDismissible({
    super.key,
    required this.valueKey,
    required this.hasDismiss,
    this.onDismissed,
    required this.child,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return common.CustomDismissible(
      key: valueKey,
      direction: hasDismiss ? common.DismissDirection.endToStart : common.DismissDirection.none,
      resizeDuration: const Duration(milliseconds: 100),
      onDismissed: (_) => onDismissed?.call(),
      background: DismissBackground(
        radius: radius,
      ),
      child: child,
    );
  }
}
