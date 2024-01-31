import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthCheckBox extends StatefulWidget {
  const AuthCheckBox({super.key});
  @override
  State<AuthCheckBox> createState() => AuthCheckBoxState();
}

class AuthCheckBoxState extends State<AuthCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: context.themeConfig
              .textFieldColor, // White when checked, grey when unchecked
          borderRadius: BorderRadius.circular(2),
        ),
        child: isChecked
            ? Center(
                child: FaIcon(
                  FontAwesomeIcons.check,
                  size: 14,
                  color: context.themeConfig.orangeTextColor,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
