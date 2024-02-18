import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';

class CommonAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final Icon? icon;
  final String buttonText;
  const CommonAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.icon = const Icon(Icons.check_circle, color: Colors.green),
    this.buttonText = 'OK',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: Text(title),
      content: Text(content, style: context.bodyLarge),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: context.themeConfig.buttonBackGroundColor,
            foregroundColor: context.themeConfig.onPrimaryTextColor,
          ),
          child: Text(buttonText),
        ),
      ],
    );
  }
}
