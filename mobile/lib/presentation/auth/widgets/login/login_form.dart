import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/utils/validator_util.dart';
import 'package:flutter_template/presentation/auth/widgets/login/auth_check_box.dart';
import 'package:flutter_template/presentation/widgets/common_text_form_field.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/auth/bloc/login/login_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  Widget _builPhoneNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CommonTextFormField(
        fillColor: context.themeConfig.textFieldColor,
        borderRadius: 20,
        prefixIcon: FontAwesomeIcons.phone,
        validator: ValidatorUtil.validatePhoneNumber,
        textController: widget.phoneNumberEditController,
        labelText: LocaleKeys.texts_phone_number.tr(),
        labelStyle: context.labelMedium.copyWith(
          color: context.themeConfig.defaultTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildRememberMeRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const AuthCheckBox(),
          const SizedBox(width: 8),
          Text(
            LocaleKeys.texts_remember_me.tr(),
            style: context.titleSmall.copyWith(
              color: context.themeConfig.defaultTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            LocaleKeys.texts_forgot_password.tr(),
            style: context.titleSmall.copyWith(
              color: context.themeConfig.orangeTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _builPhoneNumberTextField(),
          const SizedBox(height: 8),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CommonTextFormField(
                  fillColor: context.themeConfig.textFieldColor,
                  borderRadius: 20,
                  prefixIcon: FontAwesomeIcons.lock,
                  validator: ValidatorUtil.validatePassword,
                  textController: widget.passwordEditController,
                  labelText: LocaleKeys.texts_password.tr(),
                  labelStyle: context.labelMedium.copyWith(
                    color: context.themeConfig.defaultTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  errorText: state.error,
                  suffixIcon: _isObscure
                      ? FontAwesomeIcons.solidEye
                      : FontAwesomeIcons.solidEyeSlash,
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
          _buildRememberMeRow(),
        ],
      ),
    );
  }
}
