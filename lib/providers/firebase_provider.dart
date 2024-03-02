import 'dart:async';

import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/providers/displayname_provider.dart';
import 'package:boksklapps/providers/email_provider.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// ignore: always_specify_types
final firebaseProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// ignore: always_specify_types
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// ignore: always_specify_types
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(firebaseProvider).currentUser;
});

class FirebaseAuthService {
  // Create an instance of the FirebaseAuth class.
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  // Create an instance of the FirebaseFirestore class.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user.
  User? get currentUser {
    return _firebase.currentUser;
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
      CustomSnackBars.showError(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
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
      CustomSnackBars.showError(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
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
      CustomSnackBars.showError(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
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
      CustomSnackBars.showError(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
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
      CustomSnackBars.showError(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    }
  }

  // Update the user's email address.

  Future<void> updateEmail({
    required WidgetRef ref,
    required String email,
  }) async {
    try {
      // Send an email verification to the new email address.
      await currentUser!.verifyBeforeUpdateEmail(email);

      // Update the state and Firestore with the new email address.
      await ref.read(emailProvider.notifier).updateEmail(email);
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    }
  }

  // Update the user's display name.

  Future<void> updateDisplayName({
    required WidgetRef ref,
    required String newDisplayName,
  }) async {
    try {
      // Update Firebase Auth with the new display name.
      await _firebase.currentUser!.updateDisplayName(newDisplayName);

      // Update the state and Firestore with the new display name.
      await ref
          .read(displayNameProvider.notifier)
          .setDisplayName(newDisplayName);
    } on FirebaseAuthException catch (e) {
      // Log the error to the console.
      Logger().e('Firebase error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } on PlatformException catch (e) {
      // Log the error to the console.
      Logger().e('Platform error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } on TimeoutException catch (e) {
      // Log the error to the console.
      Logger().e('Timeout error: $e');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    } catch (e, s) {
      // Log the error to the console.
      Logger().e('Error: $e\nStackTrace: $s');

      // Show a SnackBar with the error message to the user.
      CustomSnackBars.showError(ref, e);
    }
  }
}
