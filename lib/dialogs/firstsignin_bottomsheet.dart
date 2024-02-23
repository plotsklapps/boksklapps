import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/dialogs/signin_bottomsheet.dart';
import 'package:boksklapps/dialogs/signup_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetFirstSignin extends StatelessWidget {
  const BottomSheetFirstSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Choose an option to continue'),
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
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade().moveX(delay: 200.ms, begin: -32),
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
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms, begin: -32),
            ListTile(
              onTap: () async {
                await _continueAsSneakPeeker(context);
              },
              leading: const FaIcon(FontAwesomeIcons.userSecret),
              title: const Text('Sneak peek'),
              subtitle: const Text(
                'Try out BOKSklapps anonymously without storing any data.',
              ),
              // Watching a computed signal to provide the
              // corresponding Widget.
              trailing: cShowSpinner.watch(context),
            ).animate().fade(delay: 400.ms).moveX(delay: 600.ms, begin: -32),
          ],
        ),
      ),
    );
  }

  Future<void> _continueAsSneakPeeker(BuildContext context) async {
    // Start the spinner and sign in 'anonymously'.
    sShowSpinner.value = true;
    await AuthService().signInAnonymously(
      onError: _handleErrors,
      onSuccess: () {
        _handleSuccess(context);
      },
    );
  }

  void _handleErrors(String error) {
    // Log the error, set the user as NOT Sneak Peeker, cancel the
    // spinner and show a SnackBar to the user.
    Logger().e('Error: $error');
    sSneakPeeker.value = false;
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
    // Log the success, set the user as Sneak Peeker, cancel the
    // spinner, navigate to the home screen and show a SnackBar
    // to the user.
    Logger().i('User has signed in as Sneak Peeker.');
    sSneakPeeker.value = true;
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
