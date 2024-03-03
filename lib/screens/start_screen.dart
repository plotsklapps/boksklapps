import 'package:boksklapps/dialogs/firstsignin_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
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
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Delay the checkAuthentication method to avoid initial build errors.
    Future<void>.delayed(Duration.zero, _checkAuthentication);
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

  Future<void> _checkAuthentication() async {
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    final User? currentUser = _firebase.currentUser;

    if (currentUser != null) {
      if (currentUser.emailVerified) {
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Navigate to the HomeScreen.
        Navigate.toHomeScreen(context);
      } else {
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();
        // Show a SnackBar to the user.
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: const Text('Have you verified your email address?'),
            action: SnackBarAction(
              label: 'RESEND',
              onPressed: currentUser.sendEmailVerification,
            ),
          ),
        );
      }
    } else {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }
}
