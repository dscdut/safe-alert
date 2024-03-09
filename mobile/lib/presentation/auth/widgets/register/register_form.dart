import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/utils/validator_util.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/auth/bloc/register/register_bloc.dart';
import 'package:flutter_template/presentation/auth/widgets/register/custom_text_form_fiefd.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const RegisterForm({
    required this.formKey,
    required this.fullNameController,
    required this.phoneNumberController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String? nameErrorText;
  String? phoneErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.texts_full_name.tr(),
                style: context.labelLarge,
              ),
              CustomTextFormField(
                controller: widget.fullNameController,
                validator: ValidatorUtil.validateName,
                onChanged: (value) {
                  setState(() {
                    nameErrorText = ValidatorUtil.validateName(
                      widget.fullNameController.text,
                    );
                  });
                  return;
                },
                errorText: nameErrorText,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.texts_phone_number.tr(),
                style: context.labelLarge,
              ),
              CustomTextFormField(
                controller: widget.phoneNumberController,
                validator: ValidatorUtil.validatePhoneNumber,
                onChanged: (value) {
                  setState(() {
                    phoneErrorText = ValidatorUtil.validatePhoneNumber(value);
                  });
                  return;
                },
                errorText: phoneErrorText,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.texts_email_address.tr(),
                style: context.labelLarge,
              ),
              CustomTextFormField(
                controller: widget.emailController,
                validator: ValidatorUtil.validateEmail,
                onChanged: (value) {
                  setState(() {
                    emailErrorText = ValidatorUtil.validateEmail(value);
                  });
                  return;
                },
                errorText: emailErrorText,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.texts_password.tr(),
                style: context.labelLarge,
              ),
              CustomTextFormField(
                controller: widget.passwordController,
                validator: ValidatorUtil.validatePassword,
                onChanged: (value) {
                  setState(() {
                    passwordErrorText = ValidatorUtil.validatePassword(value);
                  });
                  return;
                },
                errorText: passwordErrorText,
                isPassword: true,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.texts_confirm_password.tr(),
                style: context.labelLarge,
              ),
              CustomTextFormField(
                controller: widget.confirmPasswordController,
                validator: (value) {
                  return ValidatorUtil.validateConfirmPassword(
                    value,
                    widget.passwordController.text,
                  );
                },
                onChanged: (value) {
                  setState(() {
                    confirmPasswordErrorText =
                        ValidatorUtil.validateConfirmPassword(
                      value,
                      widget.passwordController.text,
                    );
                  });
                  return;
                },
                errorText: confirmPasswordErrorText,
                isPassword: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
