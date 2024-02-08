import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> createUserDoc({
    required UserCredential userCredential,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final DocumentReference<Map<String, dynamic>> userDoc =
          firestore.collection('users').doc(userCredential.user!.uid);

      await userDoc.set(<String, Object?>{
        'uid': userCredential.user!.uid, // String
        'email': userCredential.user!.email, // String
        'displayName': userCredential.user!.displayName, // String
        'emailVerified': userCredential.user!.emailVerified, // bool
        'photoURL': userCredential.user!.photoURL, // String
        'isAnonymous': userCredential.user!.isAnonymous, // bool
        'creationDate': userCredential.user!.metadata.creationTime, // DateTime
        'lastSignInDate':
            userCredential.user!.metadata.lastSignInTime, // DateTime
        'lastVisitDate': sLastVisitDate.value, // DateTime
        'isSneakPeeker': sSneakPeeker.value, // bool
        'ageInYrs': 0, // int
        'heightInCm': 0, // int
        'weightInKgs': 0, // int
        'totalWorkouts': 0, // int
      });
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

      // Force the sCurrentUser signal to update, so other
      // signals that depend on it will also update.
      sCurrentUser.value = userCredential.user;
      sSneakPeeker.value = false;

      onSuccess(userCredential);
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> signInAnonymously({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    try {
      // For now, I don't want Firebase to be used for anonymous sign-ins.
      // It clutters the authentication list and makes it harder to
      // find real users. For now, I'll just use a boolean to indicate
      // that the user is a sneak peeker.

      // final UserCredential userCredential =
      //     await FirebaseAuth.instance.signInAnonymously();

      // sCurrentUser.value = userCredential.user;

      sSneakPeeker.value = true;

      onSuccess();
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

      // Force the sCurrentUser signal to update, so other
      // signals that depend on it will also update.
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

      // Force the sCurrentUser signal to update, so other
      // signals that depend on it will also update.
      sCurrentUser.value = FirebaseAuth.instance.currentUser;

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
      // Update the Firebase user and reload.
      await currentUser.updateDisplayName(newDisplayName);
      await currentUser.reload();

      // Force the sCurrentUser signal to update, so other
      // signals that depend on it will also update.
      sCurrentUser.value = FirebaseAuth.instance.currentUser;

      // Update the Firestore document.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update(<Object, Object?>{'displayName': cDisplayName.value});

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> setEmail({
    required String newEmail,
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      onError('No user is currently signed in.');
      return;
    }

    try {
      // Update the Firebase user and reload.
      await currentUser.verifyBeforeUpdateEmail(newEmail);
      await currentUser.reload();

      // Force the sCurrentUser signal to update, so other
      // signals that depend on it will also update.
      sCurrentUser.value = FirebaseAuth.instance.currentUser;

      // Update the Firestore document.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update(<Object, Object?>{'email': cEmail.value});

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> setLastVisitDate({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    if (sCurrentUser.value == null) {
      onError('No user is currently signed in.');
      return;
    }

    try {
      // Force the sLastVisitDate signal to update.
      sLastVisitDate.value = DateTime.now();

      // Update the Firestore document.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(sCurrentUser.value!.uid)
          .update(<Object, Object?>{'lastVisitDate': sLastVisitDate.value});

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> getLastVisitDate({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    if (sCurrentUser.value == null) {
      onError('No user is currently signed in.');
      return;
    }

    try {
      // Fetch the Firestore document.
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(sCurrentUser.value!.uid)
              .get();

      // Set the field from Firestore to the value of the signal.
      sLastVisitDate.value = userDoc['lastVisitDate'] as DateTime;
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> setTotalWorkouts({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      onError('No user is currently signed in.');
      return;
    }

    try {
      // Force the sTotalWorkouts signal to update.
      sTotalWorkouts.value++;

      // Update the Firestore document.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update(<Object, Object?>{'totalWorkouts': sTotalWorkouts.value});

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }

  Future<void> getTotalWorkouts({
    required void Function(String) onError,
    required void Function() onSuccess,
  }) async {
    if (sCurrentUser.value == null) {
      onError('No user is currently signed in.');
      return;
    }

    try {
      // Fetch the Firestore document.
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(sCurrentUser.value!.uid)
              .get();

      // Set the field from Firestore to the value of the signal.
      sTotalWorkouts.value = userDoc['totalWorkouts'] as int;
    } on FirebaseAuthException catch (error) {
      onError('Firebase error: ${error.code}, ${error.message}');
    } catch (error) {
      onError('Error: $error');
    }
  }
}
