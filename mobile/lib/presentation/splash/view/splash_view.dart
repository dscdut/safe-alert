import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/presentation/auth/bloc/auth/auth_bloc.dart';
import 'package:flutter_template/presentation/splash/bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(
        authBloc: context.read<AuthBloc>(),
      ),
      lazy: false,
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Assets.images.logo.svg(),
            ),
            const Spacer(),
          ],
        ),
      ),
      backgroundColor: context.themeConfig.splashBackgroundColor,
    );
  }
}
