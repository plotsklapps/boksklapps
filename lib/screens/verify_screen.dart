import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class VerifyScreen extends ConsumerWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          await _validateAndVerify(context, ref);
        },
        child: ref.watch(spinnerProvider),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomBarTitle(
        title: 'Verify Email',
        hasLeading: false,
      ),
    );
  }

  Future<void> _validateAndVerify(BuildContext context, WidgetRef ref) async {
    // Create an instance of the AuthService.
    final AuthService authService = AuthService();

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Call the reload method of the AuthService to check if the email has
    // been verified.
    await authService.reload(
      onError: (String error) {
        _handleErrors(
          error,
          ref,
        );
      },
      onSuccess: ({
        required bool emailVerified,
      }) {
        _handleSuccess(
          context,
          emailVerified,
          ref,
        );
      },
    );

    // Cancel the spinner.
    ref.read(spinnerProvider.notifier).cancelSpinner();
  }

  void _handleErrors(String error, WidgetRef ref) {
    // Log the error to the console.
    Logger().e('Error: $error');

    // Cancel the spinner.
    ref.read(spinnerProvider.notifier).cancelSpinner();

    // Show a SnackBar with the error message to the user.
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          'Error: $error',
          style: TextStyle(
            color: ref.watch(themeProvider.notifier).isDark
                ? flexSchemeDark.onError
                : flexSchemeLight.onError,
          ),
        ),
        showCloseIcon: true,
        backgroundColor: ref.watch(themeProvider.notifier).isDark
            ? flexSchemeDark.error
            : flexSchemeLight.error,
      ),
    );
  }

  void _handleSuccess(BuildContext context, bool emailVerified, WidgetRef ref) {
    if (emailVerified) {
      // Log the success to the console.
      Logger().i('Email verified: $emailVerified');

      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      // Navigate to the home screen.
      Navigate.toHomeScreen(context);

      // Show a SnackBar with the success message to the user.
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Email has been verified. Welcome to BOKSklapps!'),
          showCloseIcon: true,
        ),
      );
    } else {
      // User might have already verified, but the backend has not yet
      // updated. Show a SnackBar to the user to try again.
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            'Our backend needs more time. Take three deep breaths and try '
            'again.',
            style: TextStyle(
              color: ref.watch(themeProvider.notifier).isDark
                  ? flexSchemeDark.onError
                  : flexSchemeLight.onError,
            ),
          ),
          showCloseIcon: true,
          backgroundColor: ref.watch(themeProvider.notifier).isDark
              ? flexSchemeDark.error
              : flexSchemeLight.error,
        ),
      );
    }
  }
}
