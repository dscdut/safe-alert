import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/app_bloc_observer.dart';
import 'package:flutter_template/common/helpers/firebase_messaging_service.dart';
import 'package:flutter_template/common/helpers/local_notification_service.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/flavors.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef BootstrapBuilder = FutureOr<Widget> Function();

Future<void> bootstrap(BootstrapBuilder builder, Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppFlavor.appFlavor = flavor;

  await initializeApp();

  runApp(
    await builder(),
  );
}

Future<void> initializeApp() async {
  await Hive.initFlutter();

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    MobileAds.instance.initialize(),
    configureDependencies(),
    Firebase.initializeApp(options: AppFlavor.firebaseOptions),
  ]);
  EasyLocalization.logger.enableBuildModes = [];

  await LocalNotificationService.init();

  await FirebaseMessagingService.init();

  Bloc.observer = AppBlocObserver();
}
