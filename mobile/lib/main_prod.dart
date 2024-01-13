import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/bootstrap.dart';
import 'package:flutter_template/flavors.dart';

Future<void> main() async {
  await bootstrap(
    () {
      return const App();
    },
    Flavor.PROD,
  );
}
