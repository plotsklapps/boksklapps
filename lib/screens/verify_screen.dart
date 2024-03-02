import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/age_provider.dart';
import 'package:boksklapps/providers/bmi_provider.dart';
import 'package:boksklapps/providers/height_provider.dart';
import 'package:boksklapps/providers/lastvisit_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/weight_provider.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  const VerifyScreen({super.key});

  @override
  ConsumerState<VerifyScreen> createState() {
    return VerifyScreenState();
  }
}

class VerifyScreenState extends ConsumerState<VerifyScreen> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
            Text(
              'Please check your spam folder as well.',
              style: TextUtils.fontL,
            ),
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
          await _validateAndVerify();
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

  Future<void> _validateAndVerify() async {
    final User? currentUser = _firebase.currentUser;

    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    if (currentUser == null) {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      // Show a SnackBar.
      CustomSnackBars.showError(
        ref,
        'No user is currently signed in.',
      );
      return;
    }

    try {
      // Force reload the current user.
      await currentUser.reload();

      if (currentUser.emailVerified) {
        // Create a Firestore document.
        final DocumentReference<Map<String, dynamic>> userDoc =
            _firestore.collection('users').doc(currentUser.uid);

        // Create a new Firestore document for the newly created user.
        await userDoc.set(
          <String, dynamic>{
            'uid': currentUser.uid,
            'email': currentUser.email,
            'displayName': currentUser.displayName,
            'photoURL': currentUser.photoURL,
            'emailVerified': currentUser.emailVerified,
            'creationDate': currentUser.metadata.creationTime,
            'age': ref.watch(ageProvider),
            'height': ref.watch(heightProvider),
            'weight': ref.watch(weightProvider),
            'bmi': ref.watch(bmiProvider),
            'lastVisit': ref.watch(lastVisitProvider),
            'totalWorkouts': 0, // DateTime
          },
        );

        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Navigate to the HomeScreen.
        if (mounted) {
          Navigate.toHomeScreen(context);
        }

        // Show a SnackBar.
        CustomSnackBars.showSuccess(
          ref,
          'Your email has been verified. Welcome to BOKSklapps!',
        );
      } else {
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Show a SnackBar.
        CustomSnackBars.showError(
          ref,
          'Our servers need a minute. Please take a few deep '
          'breaths and try again.',
        );
        return;
      }
    } catch (error) {
      // Log the error to the console.
      Logger().e(error);

      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();

      // Show a SnackBar.
      CustomSnackBars.showError(ref, error.toString());
    }
  }
}
