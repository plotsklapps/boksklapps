import 'dart:async';

import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/providers/age_provider.dart';
import 'package:boksklapps/providers/bmi_provider.dart';
import 'package:boksklapps/providers/height_provider.dart';
import 'package:boksklapps/providers/lastvisit_provider.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:boksklapps/providers/weight_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    }
  }

  // Sign in an existing user.

  Future<void> signInWithEmailAndPassword({
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    try {
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
    }
  }

  // Sign in anonymously.

  Future<void> signInAnonymously({
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

  // Sign out the current user.

  Future<void> signOut({
    required WidgetRef ref,
  }) async {
    try {
      await _firebase.signOut();
      // TODO(plotsklapps): Add invalidate all providers method here.
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
    required WidgetRef ref,
    required String email,
  }) async {
    try {
      // Send a password reset email to the user.
      await _firebase.sendPasswordResetEmail(email: email);
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

  Future<void> reloadUser({
    required WidgetRef ref,
  }) async {
    try {
      // Reload the current user.
      await currentUser!.reload();
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

  // Delete the current user.

  Future<void> deleteUser({
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    try {
      // Reauthenticate the current user.
      await currentUser!
          .reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: password,
        ),
      )
          .then((UserCredential value) {
        // Delete the user.
        currentUser!.delete();
      });
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

  // Update the user's email address.

  Future<void> setEmail({
    required WidgetRef ref,
    required String email,
  }) async {
    try {
      // Send an email verification to the new email address.
      await currentUser!.verifyBeforeUpdateEmail(email);
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
