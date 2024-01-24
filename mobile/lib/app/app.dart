import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/app/bloc/app_bloc.dart';
import 'package:flutter_template/common/constants/locales.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/flavors.dart';
import 'package:flutter_template/generated/codegen_loader.g.dart';
import 'package:flutter_template/presentation/auth/bloc/auth/auth_bloc.dart';
import 'package:flutter_template/router/app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void dispose() {
    _navigator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        AppLocales.en,
        AppLocales.vi,
      ],
      path: AppLocales.path,
      fallbackLocale: AppLocales.en,
      startLocale: AppLocales.en,
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ScreenUtilInit(
          designSize: const Size(414, 896),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthBloc(
                  userRepository: getIt.get<UserRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => AppBloc(),
                lazy: false,
              ),
            ],
            child: BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) =>
                  previous.themeMode != current.themeMode,
              builder: (context, state) {
                return MaterialApp(
                  navigatorKey: _navigatorKey,
                  title: AppFlavor.title,
                  theme: themes[ThemeMode.light]!.themeData,
                  darkTheme: themes[ThemeMode.dark]!.themeData,
                  themeMode: context.read<AppBloc>().state.themeMode,
                  onGenerateRoute: AppRouter.onGenerateRoute,
                  initialRoute: AppRouter.splash,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  builder: (_, child) {
                    return BlocListener<AuthBloc, AuthState>(
                      listener: (_, state) {
                        switch (state.status) {
                          case AuthenticationStatus.unknown:
                            break;
                          case AuthenticationStatus.authenticated:
                            _navigator.pushNamedAndRemoveUntil(
                              AppRouter.root,
                              (route) => false,
                            );
                            break;
                          case AuthenticationStatus.unauthenticated:
                            _navigator.pushNamedAndRemoveUntil(
                              AppRouter.login,
                              (route) => false,
                            );
                            break;
                        }
                      },
                      child: child,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
