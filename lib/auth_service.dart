import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required void Function(String) onError,
    required void Function(UserCredential) onSuccess,
  }) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      sCurrentUser.value = userCredential.user;

      onSuccess(userCredential);
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> sendEmailVerification({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      onError('No user is currently signed in.');
      return;
    }

    if (!currentUser.emailVerified) {
      try {
        await currentUser.sendEmailVerification();
        onSuccess();
      } on FirebaseAuthException catch (error) {
        onError('Firebase error: ${error.code}, ${error.message}');
      } catch (error) {
        onError('Error: $error');
      }
    } else {
      onError('Email is already verified.');
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required void Function(String) onError,
    required void Function(UserCredential) onSuccess,
  }) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      sCurrentUser.value = userCredential.user;

      onSuccess(userCredential);
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> signInAnonymously({
    required void Function(String) onError,
    required void Function(UserCredential) onSuccess,
  }) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      sCurrentUser.value = userCredential.user;

      onSuccess(userCredential);
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> sendPasswordResetEmail({
    required String email,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      onSuccess();
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> signOut({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      onError('No user is currently signed in.');
      return;
    }

    try {
      await FirebaseAuth.instance.signOut();

      sCurrentUser.value = null;

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
      return;
    } catch (error) {
      onError('Error: $error');
      return;
    }
  }

  Future<void> reload({
    required void Function(String) onError,
    required void Function({required bool emailVerified}) onSuccess,
  }) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      onError('No user is currently signed in.');
      return;
    }

    try {
      await currentUser.reload();

      sCurrentUser.value = currentUser;

      onSuccess(emailVerified: currentUser.emailVerified);
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> setDisplayName({
    required String newDisplayName,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      onError('No user is currently signed in.');
      return;
    }

    try {
      await currentUser.updateDisplayName(newDisplayName);
      await currentUser.reload();

      sCurrentUser.value = currentUser;

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
      return;
    }
  }
}
