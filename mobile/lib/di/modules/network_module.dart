import 'package:injectable/injectable.dart';

import 'package:flutter_template/common/helpers/dio_helper.dart';
import 'package:flutter_template/di/providers/dio_provider.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  DioHelper provideDioHelper(DioProvider dioProvider) {
    return DioHelper(dio: dioProvider.getDio());
  }
}
