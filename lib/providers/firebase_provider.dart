import 'dart:async';

import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/age_provider.dart';
import 'package:boksklapps/providers/bmi_provider.dart';
import 'package:boksklapps/providers/height_provider.dart';
import 'package:boksklapps/providers/lastvisit_provider.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/weight_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class FirebaseAuthService {
  // Create an instance of the FirebaseAuth class.
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  // Create an instance of the FirebaseFirestore class.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user.
  User? get currentUser {
    return _firebase.currentUser;
  }

  // Sign up a new user.

  Future<void> createUserWithEmailAndPassword({
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    try {
      // Create a new user with the email and password.
      final UserCredential userCredential =
          await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send a verification email to the newly created user.
      await userCredential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    }
  }

  // Create a Firestore document for the newly created user.

  Future<void> createUserDocument({
    required WidgetRef ref,
  }) async {
    try {
      // Start the spinner.
      ref.read(spinnerProvider.notifier).startSpinner();

      final DocumentReference<Map<String, dynamic>> userDoc =
          _firestore.collection('users').doc(_firebase.currentUser!.uid);

      // Create a new Firestore document for the newly created user.
      await userDoc.set(
        <String, dynamic>{
          'uid': _firebase.currentUser!.uid,
          'email': _firebase.currentUser!.email,
          'displayName': _firebase.currentUser!.displayName,
          'photoURL': _firebase.currentUser!.photoURL,
          'emailVerified': _firebase.currentUser!.emailVerified,
          'creationDate': _firebase.currentUser!.metadata.creationTime,
          'age': ref.watch(ageProvider),
          'height': ref.watch(heightProvider),
          'weight': ref.watch(weightProvider),
          'bmi': ref.watch(bmiProvider),
          'lastVisit': ref.watch(lastVisitProvider),
          'totalWorkouts': 0, // DateTime
        },
      );
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } finally {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }

  // Sign in an existing user.

  Future<void> signInWithEmailAndPassword({
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    try {
      // Start the spinner.
      ref.read(spinnerProvider.notifier).startSpinner();

      // Sign in the user with the email and password.
      await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } finally {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }

  // Sign in anonymously.

  Future<void> signInAnonymously({
    required WidgetRef ref,
  }) async {
    try {
      // Start the spinner.
      ref.read(spinnerProvider.notifier).startSpinner();

      // Sign in the user 'anonymously'. For now, that means just setting
      // the sneakpeekprovider to true.
      await ref.read(sneakPeekProvider.notifier).setSneakPeek(
            isSneakPeeker: true,
          );
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } finally {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }

  // Check authentication and emailverification.

  Future<void> checkAuthentication({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      // Start the spinner.
      ref.read(spinnerProvider.notifier).startSpinner();

      // Check if there is a current user signed in.
      final User? user = _firebase.currentUser;

      if (user != null) {
        if (user.emailVerified) {
          // Create a Firestore document for the newly created user.
          await createUserDocument(ref: ref);

          // Navigate to the HomeScreen.
          if (context.mounted) {
            Navigate.toHomeScreen(context);
          }
        } else {
          // Show a SnackBar with a message to the user to resend
          // the verification email.
          rootScaffoldMessengerKey.currentState!.showSnackBar(
            SnackBar(
              content: const Text(
                'Please verify your email to continue.',
              ),
              action: SnackBarAction(
                label: 'Resend',
                onPressed: () async {
                  await user.sendEmailVerification();
                },
              ),
            ),
          );
        }
      } else {
        // If user is NOT signed in.
        return;
      }
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } finally {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }

  // Sign out the current user.

  Future<void> signOut({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      // Start the spinner.
      ref.read(spinnerProvider.notifier).startSpinner();

      if (ref.watch(sneakPeekProvider)) {
        // There is no user to sign out.
        Navigate.toStartScreen(context);
      } else {
        // Sign out the current user.
        await _firebase.signOut();
      }
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } finally {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }

  // Send a password reset email to the user.

  Future<void> sendPasswordResetEmail({
    required WidgetRef ref,
    required String email,
  }) async {
    try {
      // Start the spinner.
      ref.read(spinnerProvider.notifier).startSpinner();

      // Send a password reset email to the user.
      await _firebase.sendPasswordResetEmail(email: email);

      // Show a SnackBar with the success message to the user.
      CustomSnackBars.showSuccessSnackBar(
          ref,
          'Password reset email sent, '
          'check your inbox (and spam folder)');
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } finally {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }
}
