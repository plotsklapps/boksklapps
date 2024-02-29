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

class VerifyScreen extends ConsumerStatefulWidget {
  const VerifyScreen({super.key});

  @override
  ConsumerState<VerifyScreen> createState() {
    return VerifyScreenState();
  }
}

class VerifyScreenState extends ConsumerState<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
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
    final User? currentUser = FirebaseAuthService().currentUser;

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Reload the currentUser every time the user clicks the button.
    await currentUser?.reload();

    try {
      if (currentUser != null && !currentUser.emailVerified) {
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();
        return;
      } else if (currentUser != null && currentUser.emailVerified) {
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
      } catch (e) {
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Show a SnackBar with the error message to the user.
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: FlexColors.red,
            showCloseIcon: true,
          ),
        );
      }
  }
}
