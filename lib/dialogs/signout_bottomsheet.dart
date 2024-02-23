import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetSignout extends StatelessWidget {
  const BottomSheetSignout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: 'Are you sure you want to sign '
                  'out?',
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    await _validateAndSignout(context);
                  },
                  child: cShowSpinner.watch(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateAndSignout(BuildContext context) async {
    sShowSpinner.value = true;
    if (sSneakPeeker.value) {
      // If the user is sneak peeking, just return to the
      // Splash Screen. No need to sign out the user.
      sSneakPeeker.value = false;
      Logger().i('User has signed out.');
      Navigator.pop(context);
      Navigate.toSplashScreen(context);
    } else {
      // Sign out the user completely and return to the
      // Splash Screen.
      await AuthService().signOut(
        onError: _handleErrors,
        onSuccess: () {
          _handleSuccess(context);
        },
      );
    }
  }

  void _handleErrors(String error) {
    // Log the error, cancel the spinner and show a SnackBar with the
    // error message to the user.
    Logger().e('Error: $error');
    sShowSpinner.value = false;
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  void _handleSuccess(BuildContext context) {
    // Log the success, cancel the spinner, navigate to the splashscreen
    // and show a SnackBar to the user.
    Logger().i('User has signed out.');
    sShowSpinner.value = false;
    Navigate.toSplashScreen(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text('You have been successfully signed out.'),
        showCloseIcon: true,
      ),
    );
  }
}
