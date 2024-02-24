import 'package:flutter/material.dart';
import 'package:flutter_template/presentation/auth/auth.dart';
// import 'package:flutter_template/presentation/auth/views/login_view.dart';
import 'package:flutter_template/presentation/auth/views/register_view.dart';
import 'package:flutter_template/presentation/home/home.dart';
import 'package:flutter_template/presentation/map/views/map_view.dart';
import 'package:flutter_template/presentation/core/views/root_view.dart';
import 'package:flutter_template/presentation/splash/splash.dart';

abstract final class AppRouter {
  static const String splash = '/';

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String map = '/map';

  // Root
  static const String root = '/root';
  static const String home = '/home';

  // static final router = GoRouter(
  //   routes: [
  //     GoRoute(
  //       path: login,
  //       pageBuilder: (_, __) {
  //         return const MaterialPage(
  //           child: LoginPage(),
  //         );
  //       },
  //     ),
  //     GoRoute(
  //       path: register,
  //       pageBuilder: (_, __) {
  //         return const MaterialPage(
  //           child: RegisterView(),
  //         );
  //       },
  //     ),
  //     GoRoute(
  //       path: root,
  //       pageBuilder: (_, __) {
  //         return const MaterialPage(
  //           child: RootPage(),
  //         );
  //       },
  //     )
  //   ],
  //   initialLocation: login,
  // );

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) {
            return const SplashPage();
          },
        );
      case login:
        return MaterialPageRoute(
          builder: (_) {
            return const LoginPage();
          },
        );
      case register:
        return MaterialPageRoute(
          builder: (_) {
            return const RegisterPage();
          },
        );
      case home:
        return MaterialPageRoute(
          builder: (_) {
            return const HomePage();
          },
        );
      case root:
        return MaterialPageRoute(
          builder: (_) {
            return const RootPage();
          },
        );
      default:
        return null;
    }
  }
}
