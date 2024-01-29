import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetFirstSignin extends ConsumerWidget {
  const BottomSheetFirstSignin({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () async {
              // Handle createUser logic.
            },
            leading: const FaIcon(
              FontAwesomeIcons.userPlus,
            ),
            title: const Text('Create an account'),
            subtitle: const Text(
              'Get a personalized experience and save your statistics (recommended).',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () async {
              // Handle createUser logic.
            },
            leading: const FaIcon(
              FontAwesomeIcons.userCheck,
            ),
            title: const Text('Use an existing account'),
            subtitle: const Text(
              'You already used BOKSklapps before and want to sign in again.',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () async {
              // Set isSneakPeeker bool true.
              ref.read(isSneakPeeker.notifier).setTrue();
              Navigator.pop(context);
              Navigation.navigateToHomeScreen(context);
              rootScaffoldMessengerKey.currentState!.showSnackBar(
                const SnackBar(
                  content: Text(
                    'Welcome to BOKSklapps! You are a sneak peeker, your data will not be stored.',
                  ),
                ),
              );
            },
            leading: const FaIcon(
              FontAwesomeIcons.userSecret,
            ),
            title: const Text('Sneak peek'),
            subtitle: const Text(
              'Try out BOKSklapps without storing any data.',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
        ],
      ),
    );
  }
}
