import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/presentation/auth/bloc/auth/auth_bloc.dart';
import 'package:flutter_template/presentation/widgets/common_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() onTap;
  const MyAppBar({super.key, required this.onTap});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Column(
        children: [
          const SizedBox(height: 24.0),
          CommonTextFormField(
            onTap: onTap,
            onTapPrefixIcon: onTap,
            prefixIcon: (FontAwesomeIcons.magnifyingGlass),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              // Navigator.of(context).pushNamed('/notification');
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.4,
                    color: Colors.black54,
                    blurRadius: 0.4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(FontAwesomeIcons.solidBell, size: 32),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.4,
                    color: Colors.black54,
                    blurRadius: 0.4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(FontAwesomeIcons.solidCircleUser, size: 32),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(const AuthUserInfoSet(currentUser: null));
            },
            icon: const Icon(Icons.settings),
          ),
        ),
      ],
    );
  }
}
