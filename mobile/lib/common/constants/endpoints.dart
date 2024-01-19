import 'package:flutter_template/flavors.dart';

abstract class Endpoints {
  static String apiUrl = '${AppFlavor.apiBaseUrl}/docs/#';

  static String login = '$apiUrl/auth/login';
  static String userInfo = '$apiUrl/auth/me';
  static String register = '$apiUrl/auth/post_auth_register';
}
