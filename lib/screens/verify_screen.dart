import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('A verification email has been sent.'),
            SizedBox(height: 16),
            Text('Please check your spam folder as well.'),
            SizedBox(height: 16),
            Text('Click the button below AFTER verifying your email address.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          sShowSpinner.value = true;
          await authService.reload(
            onError: _handleErrors,
            onSuccess: ({
              required bool emailVerified,
            }) {
              _handleSuccess(context, emailVerified);
            },
          );
        },
        child: cShowSpinner.watch(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomAppBar(
        height: 64,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Text(
          'VERIFY EMAIL',
          style: TextUtils.fontXL,
        ),
      ),
    );
  }

  void _handleErrors(String error) {
    // Log the error, cancel the spinner and show a SnackBar to the user.
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

  void _handleSuccess(BuildContext context, bool emailVerified) {
    if (emailVerified) {
      // Log the success, cancel the spinner, navigate to the home screen
      // and show a SnackBar to the user.
      Logger().i('Email verified: $emailVerified');
      sShowSpinner.value = false;
      Navigate.toHomeScreen(context);
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Email has been verified. Welcome to BOKSklapps!'),
          showCloseIcon: true,
        ),
      );
    } else {
      // User might have already verified, but the backend has not yet
      // updated. Tell the user to wait.
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            'Our backend needs more time. Take three deep breaths and try '
            'again.',
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
  }
}
