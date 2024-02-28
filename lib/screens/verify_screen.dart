import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<void> _validateAndVerify(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // Create an instance of the AuthService.
    final FirebaseAuthService authService = FirebaseAuthService();

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    try {
      // Reload the currentUser every time the user clicks the button.
      await authService.reload(ref);

      // Fetch the current user after reload.
      final User? currentUser = FirebaseAuth.instance.currentUser;

      // Check if the current user is created.
      if (currentUser != null) {
        // Check if the email is verified.
        if (currentUser.emailVerified) {
          // Cancel the spinner.
          ref.read(spinnerProvider.notifier).cancelSpinner();
          // Navigate to the HomeScreen.
          if (context.mounted) {
            Navigate.toHomeScreen(context);
          }
          // Show a SnackBar with the success message to the user.
          rootScaffoldMessengerKey.currentState!.showSnackBar(
            const SnackBar(
              content: Text('Email has been verified. Welcome to BOKSklapps!'),
              showCloseIcon: true,
            ),
          );
        } else {
          // Show a SnackBar with the error message to the user.
          rootScaffoldMessengerKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(
                'Take a few breaths and try again. Our server has not yet '
                'updated.',
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
      } else {
        // Show a SnackBar with the error message to the user.
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(
              'User not found. Please sign in again.',
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
    } catch (e) {
      // Show a SnackBar with the error message to the user.
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again.'),
          showCloseIcon: true,
        ),
      );
    } finally {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }
}
