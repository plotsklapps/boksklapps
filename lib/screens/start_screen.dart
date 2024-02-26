import 'package:boksklapps/dialogs/firstsignin_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() {
    return StartScreenState();
  }
}

class StartScreenState extends ConsumerState<StartScreen> {
  late final User? _user;

  @override
  void initState() {
    super.initState();
    _user = ref.read(firebaseProvider);
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Delay this function to avoid initState issues.
    await Future<void>.delayed(const Duration(milliseconds: 800), () async {
      // Check if the user is signed in.
      if (_user != null) {
        // Check if the user has verified their email.
        if (_user.emailVerified) {
          // Cancel the spinner.
          ref.read(spinnerProvider.notifier).cancelSpinner();

          // Navigate to the home screen.
          Navigate.toHomeScreen(context);
        }
        // If the user is signed in, but NOT verified, show a SnackBar to
        // the user to resend a verification mail.
        else if (!_user.emailVerified) {
          // Cancel the spinner.
          ref.read(spinnerProvider.notifier).cancelSpinner();

          // Show a SnackBar to the user to verify their email.
          rootScaffoldMessengerKey.currentState!.showSnackBar(
            SnackBar(
              content: const Text(
                'Please verify your email to continue.',
              ),
              action: SnackBarAction(
                label: 'Resend',
                onPressed: () async {
                  await _user.sendEmailVerification();
                },
              ),
            ),
          );
        } else {
          // Cancel the spinner.
          ref.read(spinnerProvider.notifier).cancelSpinner();
          return;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/GIF/littleBoxer.gif',
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet<void>(
              showDragHandle: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return const BottomSheetFirstSignin();
              },
            );
          },
          child: ref.watch(spinnerProvider),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: const BottomBarTitle(
          hasLeading: false,
          title: 'BOKSklapps',
        ),
      ),
    );
  }
}
