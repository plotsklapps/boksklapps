import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final NotifierProvider<EmailNotifier, String> emailProvider =
    NotifierProvider<EmailNotifier, String>(EmailNotifier.new);

class EmailNotifier extends Notifier<String> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Set the initial value of the provider to the current user's email,
  // or 'johndoe@email.com' if the user is not signed in.
  @override
  String build() {
    return state = _firebaseAuth.currentUser?.email ?? 'johndoe@email.com';
  }

  // Create a function that allows the user to change the email.
  Future<String> setEmail(String newEmail) async {
    await _firebaseAuth.currentUser?.updateEmail(newEmail);
    return state = newEmail;
  }
}
