import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final NotifierProvider<DisplayNameNotifier, String> displayNameProvider =
    NotifierProvider<DisplayNameNotifier, String>(DisplayNameNotifier.new);

class DisplayNameNotifier extends Notifier<String> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Set the initial value of the provider to the current user's display
  // name, or 'New Boxer' if the user is not signed in.
  @override
  String build() {
    return state = _firebaseAuth.currentUser?.displayName ?? 'New Boxer';
  }

  // Create a function that allows the user to change the display name.
  Future<void> setDisplayName(String displayName) async {
    await _firebaseAuth.currentUser?.updateDisplayName(displayName);
  }
}
