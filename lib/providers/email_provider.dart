import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final emailProvider =
    NotifierProvider<EmailNotifier, String>(EmailNotifier.new);

class EmailNotifier extends Notifier<String> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  String build() {
    return '';
  }

  Future<void> updateEmail(String newEmail) async {
    // Update the user's email in Firebase Authentication.
    await _firebase.currentUser?.verifyBeforeUpdateEmail(newEmail);

    // Update the user's email in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_firebase.currentUser?.uid)
        .update(<String, String?>{
      'email': newEmail,
    });

    // Update the state with the new display name.
    state = newEmail;
  }

  Future<void> getEmail() async {
    // Get the user's email from Firebase Authentication.
    final String email = _firebase.currentUser?.email ?? '';

    // Update the state.
    state = email;
  }
}
