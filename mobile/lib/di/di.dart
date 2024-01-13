import 'package:flutter_template/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'initGetIt',
  asExtension: false,
)
Future<void> configureDependencies() async => await initGetIt(getIt);
