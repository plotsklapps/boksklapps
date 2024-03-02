import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  const VerifyScreen({super.key});

  @override
  ConsumerState<VerifyScreen> createState() {
    return VerifyScreenState();
  }
}

class VerifyScreenState extends ConsumerState<VerifyScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'A verification email has been sent.',
              style: TextUtils.fontL,
            ),
            SizedBox(height: 16),
            Text('Please check your spam folder as well.'),
            SizedBox(height: 16),
            Text(
              'Click the button below AFTER verifying your email address.',
              style: TextUtils.fontL,
            ),
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
    final User? currentUser = _authService.currentUser;

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    if (currentUser == null) {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      // Show a SnackBar to the user.
      CustomSnackBars.showSuccess(
        ref,
        'No user is currently signed in.',
      );
      return;
    }

    try {
      // Force reload the current user.
      await currentUser.reload();

      // Check if the user's email has been verified.
      if (currentUser.emailVerified) {
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Navigate to the HomeScreen.
        if (context.mounted) {
          Navigate.toHomeScreen(context);
        }

        // Show a SnackBar to the user.
        CustomSnackBars.showSuccess(
          ref,
          'Your email has been verified. Welcome to BOKSklapps!',
        );
      } else {
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Show a SnackBar to the user.
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(
              'Our servers need a minute. Please take a few deep '
              'breaths and try again.',
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
        return;
      }
    } catch (e) {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    }
  }
}
