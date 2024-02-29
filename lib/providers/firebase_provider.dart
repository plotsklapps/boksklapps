import 'dart:async';

import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// ignore: always_specify_types
final currentUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class FirebaseAuthService {
  // Create an instance of the FirebaseAuth class.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign up a new user.

  Future<void> createUserWithEmailAndPassword({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    try {
      // Create a new user with the email and password.
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
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

  // Sign in an existing user.

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    try {
      // Sign in the user with the email and password.
      await _firebaseAuth.signInWithEmailAndPassword(
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
    }
  }

  // Sign in anonymously.

  Future<void> signInAnonymously({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
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
      final User? user = _firebaseAuth.currentUser;

      if (user != null) {
        if (user.emailVerified) {
          // Cancel the spinner.
          ref.read(spinnerProvider.notifier).cancelSpinner();

          // Navigate to the HomeScreen.
          Navigate.toHomeScreen(context);
        } else {
          // Cancel the spinner.
          ref.read(spinnerProvider.notifier).cancelSpinner();

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
        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();
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
    }
  }

  // Sign out the current user.

  Future<void> signOut({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      if (ref.watch(sneakPeekProvider)) {
        // There is no user to sign out.
        Navigate.toStartScreen(context);
      } else {
        // Sign out the current user.
        await _firebaseAuth.signOut();
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
    }
  }

  // Send a password reset email to the user.

  Future<void> sendPasswordResetEmail({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
  }) async {
    try {
      // Send a password reset email to the user.
      await _firebaseAuth.sendPasswordResetEmail(email: email);

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
    }
  }

  // Reload the current user.

  Future<void> reload(WidgetRef ref) async {
    final User? currentUser = _firebaseAuth.currentUser;

    if (ref.watch(sneakPeekProvider) || currentUser == null) {
      // Show a SnackBar with the error message to the user.
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            'No current user is currently signed in.',
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

    try {
      await currentUser.reload();
      CustomSnackBars.showSuccessSnackBar(
        ref,
        'User reloaded. Continuing...',
      );
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showErrorSnackBar(ref, e);
    }
  }
}
