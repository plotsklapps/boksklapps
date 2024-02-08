import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/dialogs/signin_bottomsheet.dart';
import 'package:boksklapps/dialogs/signup_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetFirstSignin extends StatelessWidget {
  const BottomSheetFirstSignin({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Choose a sign in method', style: TextUtils.fontL),
          const Divider(thickness: 2),
          const SizedBox(height: 16),
          ListTile(
            onTap: () async {
              // Close this bottomsheet and open the signup bottomsheet.
              Navigator.pop(context);
              await showModalBottomSheet<void>(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const BottomSheetSignup();
                },
              );
            },
            leading: const FaIcon(
              FontAwesomeIcons.userPlus,
            ),
            title: const Text('Create an account'),
            subtitle: const Text(
              'Get a personalized experience and save your statistics '
              '(recommended).',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () async {
              // Close this bottomsheet and open the signin bottomsheet.
              Navigator.pop(context);
              await showModalBottomSheet<void>(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const BottomSheetSignin();
                },
              );
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
              sShowSpinner.value = true;
              // Set the user as a sneak peeker and sign in anonymously.
              sSneakPeeker.value = true;
              await authService.signInAnonymously(
                onError: _handleErrors,
                onSuccess: () {
                  _handleSuccess(context);
                },
              );
            },
            leading: cShowSpinner.value,
            title: const Text('Sneak peek'),
            subtitle: const Text(
              'Try out BOKSklapps anonymously without storing any data.',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
        ],
      ),
    );
  }

  void _handleErrors(String error) {
    Logger().e('Error: $error');
    sShowSpinner.value = false;
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          'Error: $error',
          style: TextStyle(
            color: sDarkTheme.value
                ? flexSchemeDark.onError
                : flexSchemeLight.onError,
          ),
        ),
        showCloseIcon: true,
        backgroundColor:
            sDarkTheme.value ? flexSchemeDark.error : flexSchemeLight.error,
      ),
    );
  }

  void _handleSuccess(BuildContext context) {
    Logger().i('User has signed in as Sneak Peeker.');
    sShowSpinner.value = false;
    Navigate.toHomeScreen(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text(
          'Welcome to BOKSklapps! You are a sneak peeker, '
          'your data will NOT be stored.',
        ),
        showCloseIcon: true,
      ),
    );
  }
}
