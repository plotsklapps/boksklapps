import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      // Handle Firebase Exceptions here.
      return null;
    } catch (error) {
      // Handle all other errors here.
      return null;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      // Handle Firebase Exceptions here.
      return null;
    } catch (error) {
      // Handle all other errors here.
      return null;
    }
  }

  Future<UserCredential?> signInAnonymously() async {
    try {
      return await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (error) {
      // Handle Firebase Exceptions here.
      return null;
    } catch (error) {
      // Handle all other errors here.
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      // Handle Firebase Exceptions here.
      return;
    } catch (error) {
      // Handle all other errors here.
      return;
    }
  }
}
