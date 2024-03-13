import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/presentation/core/bloc/root_bloc.dart';
import 'package:flutter_template/presentation/core/widgets/slide_lazy_indexed_stack.dart';
import 'package:flutter_template/presentation/home/view/home.dart';
import 'package:flutter_template/presentation/notification/notification.dart';
import 'package:flutter_template/presentation/profile/profile.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RootBloc(),
      child: const _RootView(),
    );
  }
}

class _RootView extends StatelessWidget {
  const _RootView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RootBloc, RootState>(
        builder: (context, state) {
          return SlideIndexedStack(
            index: state.currentIndex,
            children: const [HomePage(), NotificationPage(), ProfilePage()],
          );
        },
        buildWhen: (previous, current) {
          return previous.currentIndex != current.currentIndex;
        },
      ),
    );
  }
}
