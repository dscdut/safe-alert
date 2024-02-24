import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/repositories/emergency_repository.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/presentation/emergency/bloc/set/set_emergency_case_bloc.dart';
import 'package:flutter_template/presentation/emergency/widgets/emergency_post_field.dart';

class EmergencyPostView extends StatefulWidget {
  const EmergencyPostView({super.key});

  @override
  State<EmergencyPostView> createState() => _EmergencyPostViewState();
}

class _EmergencyPostViewState extends State<EmergencyPostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: context.themeConfig.frameAvatarColor,
              radius: 50.0,
              child: CircleAvatar(
                backgroundImage: AssetImage(Assets.icons.launcher.appIcon.path),
                radius: 45.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: BlocProvider(
                create: (context) =>
                    SetEmergencyCaseBloc(getIt.get<EmergencyRepository>()),
                child: const SingleChildScrollView(child: EmergencyPostField()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
