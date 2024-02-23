import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_template/presentation/auth/widgets/login/login_form.dart';
import 'package:flutter_template/presentation/widgets/common_rounded_button.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({
    super.key,
    required this.formKey,
    required this.phoneNumberEditController,
    required this.passwordEditController,
    required this.submitLogin,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneNumberEditController;
  final TextEditingController passwordEditController;
  final Function submitLogin;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      backgroundColor: Colors.white,
      onClosing: () {},
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 36),
              Text(
                LocaleKeys.auth_sign_in.tr(),
                style: context.titleMedium.copyWith(
                  color: context.themeConfig.defaultTextColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: LoginForm(
                  formKey: formKey,
                  phoneNumberEditController: phoneNumberEditController,
                  passwordEditController: passwordEditController,
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: CommonRoundedButton(
                      textStyle: context.labelMedium.copyWith(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      borderRadius: 20,
                      backgroundColor:
                          context.themeConfig.splashBackgroundColor,
                      onPressed: () => submitLogin(context),
                      isLoading: state is LoginLoading,
                      content: LocaleKeys.auth_sign_in.tr(),
                      width: double.infinity,
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Divider(
                  color: context.themeConfig.dividerColor,
                  thickness: 1,
                  height: 1,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: LocaleKeys.texts_dont_have_account.tr(),
                        style: context.titleSmall.copyWith(
                          color: context.themeConfig.defaultTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 8)),
                      TextSpan(
                        text: LocaleKeys.auth_sign_up.tr(),
                        style: context.titleSmall.copyWith(
                          color: context.themeConfig.orangeTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
