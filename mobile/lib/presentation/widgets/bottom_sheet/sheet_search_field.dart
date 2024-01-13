import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/presentation/widgets/common_text_form_field.dart';

class SheetSearchField extends StatelessWidget {
  final String hintText;
  final void Function(String)? onFieldSubmitted;

  const SheetSearchField({
    super.key,
    required this.hintText,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSize.horizontalSpacing,
        AppSize.horizontalSpacing,
        AppSize.horizontalSpacing,
        10,
      ),
      child: CommonTextFormField(
        borderRadius: 10,
        borderColor: ColorStyles.gray200,
        prefixIcon: Icons.search,
        prefixIconColor: ColorStyles.green400,
        hintText: hintText,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
