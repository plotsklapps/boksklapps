import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/dialogs/firstsignin_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/age_provider.dart';
import 'package:boksklapps/providers/bmi_provider.dart';
import 'package:boksklapps/providers/displayname_provider.dart';
import 'package:boksklapps/providers/email_provider.dart';
import 'package:boksklapps/providers/height_provider.dart';
import 'package:boksklapps/providers/lastvisit_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/totalworkouts_provider.dart';
import 'package:boksklapps/providers/weight_provider.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() {
    return StartScreenState();
  }
}

class StartScreenState extends ConsumerState<StartScreen> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

    try {
      if (currentUser != null) {
        if (currentUser.emailVerified) {
          // Fetch user data from Firestore.
          await _firestore.collection('users').doc(currentUser.uid).get();

          // Get the  email.
          await ref.read(emailProvider.notifier).getEmail();

          // Get the display name.
          await ref.read(displayNameProvider.notifier).getDisplayName();

          // Get the age.
          await ref.read(ageProvider.notifier).getAge();

          // Get the height.
          await ref.read(heightProvider.notifier).getHeight();

          // Get the weight.
          await ref.read(weightProvider.notifier).getWeight();

          // Get the BMI.
          await ref.read(bmiProvider.notifier).getBMI();

          // Get the last visit.
          await ref.read(lastVisitProvider.notifier).getLastVisit();

          // Get the total workouts.
          await ref.read(totalWorkoutsProvider.notifier).getTotalWorkouts();

          // Cancel the spinner.
          ref.read(spinnerProvider.notifier).cancelSpinner();

          // Navigate to the HomeScreen.
          if (mounted) {
            Navigate.toHomeScreen(context);
          }
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
    } catch (error) {
      // Log the error.
      Logger().e(error);

      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      // Show a SnackBar.
      CustomSnackBars.showError(ref, error.toString());
    }
  }
}
