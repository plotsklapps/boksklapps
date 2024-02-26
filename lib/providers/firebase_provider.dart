import 'dart:async';

import 'package:boksklapps/custom_snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final NotifierProvider<FirebaseAuthService, User?> firebaseProvider =
    NotifierProvider<FirebaseAuthService, User?>(() {
  return FirebaseAuthService();
});

class FirebaseAuthService extends Notifier<User?> {
  // Create an instance of the FirebaseAuth class.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Check for an existing user. Update the state, or return null.
  @override
  User? build() {
    final User? currentUser = _firebaseAuth.currentUser;

    if (currentUser != null) {
      state = currentUser;
      return currentUser;
    } else {
      return null;
    }
  }

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

      // Update the state with the new user.
      state = userCredential.user;
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
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the state with the new user.
      state = userCredential.user;
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
}
