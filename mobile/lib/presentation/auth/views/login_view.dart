import 'dart:math';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/extensions/string_extension.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/common/utils/toast_util.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/auth/bloc/auth/auth_bloc.dart';
import 'package:flutter_template/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_template/presentation/auth/widgets/login_form.dart';
import 'package:flutter_template/presentation/widgets/common_rounded_button.dart';
import 'package:flutter_template/router/app_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        authBloc: context.read<AuthBloc>(),
        userRepository: getIt.get<UserRepository>(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: _listenLoginStateChanged,
        child: _LoginView(),
      ),
    );
  }

  void _listenLoginStateChanged(BuildContext context, LoginState state) {
    if (state is LoginNotSuccess && state.error.isNullOrEmpty) {
      ToastUtil.showError(
        context,
        text: state.error,
      );
    }
    if (state is LoginSuccess) {
      Navigator.of(context).pushNamed(AppRouter.root);
    }
  }
}

class _LoginView extends StatelessWidget {
  _LoginView();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberEditController =
      TextEditingController();
  final TextEditingController _passwordEditController = TextEditingController();

  void _submitLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
            LoginSubmit(
              phoneNumber: _phoneNumberEditController.text,
              password: _passwordEditController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.splashBackground,
      body: Column(
        children: [
          Transform.scale(
            scale: 0.8,
            child: Assets.images.logo.svg(),
          ),
          Flexible(
            child: BottomSheet(
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
                        style: const TextStyle(
                          color: ColorStyles.charcoal,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: LoginForm(
                          formKey: _formKey,
                          phoneNumberEditController: _phoneNumberEditController,
                          passwordEditController: _passwordEditController,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: CommonRoundedButton(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              borderRadius: 20,
                              backgroundColor: ColorStyles.splashBackground,
                              onPressed: () => _submitLogin(context),
                              isLoading: state is LoginLoading,
                              content: LocaleKeys.auth_sign_in.tr(),
                              width: double.infinity,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: Divider(
                          color: ColorStyles.gray140,
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
                                style: const TextStyle(
                                  color: ColorStyles.charcoal,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const WidgetSpan(child: SizedBox(width: 8)),
                              TextSpan(
                                text: LocaleKeys.auth_sign_up.tr(),
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
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               margin: const EdgeInsets.symmetric(
//                 horizontal: AppSize.horizontalSpacing,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     LocaleKeys.auth_welcome_back.tr(),
//                     style: context.bodyLarge,
//                   ),
//                   LoginForm(
//                     formKey: _formKey,
//                     emailEditController: _emailEditController,
//                     passwordEditController: _passwordEditController,
//                   ),
//                   BlocBuilder<LoginBloc, LoginState>(
//                     builder: (context, state) {
//                       return CommonRoundedButton(
//                         onPressed: () => _submitLogin(context),
//                         isLoading: state is LoginLoading,
//                         content: LocaleKeys.auth_sign_in.tr(),
//                         width: double.infinity,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),