import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final emailProvider =
    NotifierProvider<EmailNotifier, String>(EmailNotifier.new);

class EmailNotifier extends Notifier<String> {
  // Create an instance of the FirebaseAuth service.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirebaseFirestore class.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  String build() {
    return '';
  }

  Future<void> updateEmail(String newEmail) async {
    // Update the user's display name in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .update(<String, String?>{
      'email': newEmail,
    });

    // Update the state with the new display name.
    state = newEmail;
  }

  Future<void> getEmail() async {
    // Get the user's display name from the Firestore database.
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .get();
    final String email = userDoc.data()!['email'] as String;

    // Update the state with the user's display name.
    state = email;
  }
}
