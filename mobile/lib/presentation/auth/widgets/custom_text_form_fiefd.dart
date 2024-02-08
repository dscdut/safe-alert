import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/generated/assets.gen.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final IconButton? prefixIcon;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? label;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.errorText,
    this.label,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  var isObscure = true;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      obscureText: widget.isPassword && isObscure,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        errorText: widget.errorText,
        filled: true,
        fillColor: ColorStyles.textFieldBackground,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: _onPressSuffixIcon,
                icon: isObscure
                    ? Assets.icons.register.eyeClose.svg()
                    : Assets.icons.register.eyeOpen.svg(),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }

  void _onPressSuffixIcon() {
    setState(() {
      isObscure = !isObscure;
    });
  }
}
