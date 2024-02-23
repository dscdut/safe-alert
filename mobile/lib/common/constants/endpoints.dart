import 'package:flutter_template/flavors.dart';

abstract class Endpoints {
  static String apiUrl = '${AppFlavor.apiBaseUrl}/api';

  static String login = '$apiUrl/auth';
  static String userInfo = '$apiUrl/auth/me';
  static String register = '$apiUrl/auth/register';
}
