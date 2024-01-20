import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/common/utils/validator_util.dart';
import 'package:flutter_template/presentation/widgets/common_text_form_field.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/auth/bloc/login/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.phoneNumberEditController,
    required this.passwordEditController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneNumberEditController;
  final TextEditingController passwordEditController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscure = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CommonTextFormField(
              fillColor: ColorStyles.gray150,
              borderRadius: 20,
              prefixIcon: Icons.phone,
              validator: ValidatorUtil.validatePhoneNumber,
              textController: widget.phoneNumberEditController,
              labelText: LocaleKeys.texts_phone_number.tr(),
              labelStyle: const TextStyle(
                color: ColorStyles.charcoal,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CommonTextFormField(
                  fillColor: ColorStyles.gray150,
                  borderRadius: 20,
                  prefixIcon: Icons.lock,
                  validator: ValidatorUtil.validatePassword,
                  textController: widget.passwordEditController,
                  labelText: LocaleKeys.texts_password.tr(),
                  labelStyle: const TextStyle(
                    color: ColorStyles.charcoal,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.text,
                  errorText: state.error,
                  suffixIcon:
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                  onTapSuffixIcon: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  isObscure: _isObscure,
                  onChanged: (value) {},
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Checkbox(
                  visualDensity:
                      const VisualDensity(vertical: -4, horizontal: -4),
                  value: isChecked,
                  onChanged: (newBool) {
                    setState(() {
                      isChecked = newBool!;
                    });
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  activeColor: ColorStyles.gray150,
                ),
                Text(
                  LocaleKeys.texts_remember_me.tr(),
                  style: const TextStyle(
                    color: ColorStyles.charcoal,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  LocaleKeys.texts_forgot_password.tr(),
                  style: const TextStyle(
                    color: ColorStyles.orange100,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
