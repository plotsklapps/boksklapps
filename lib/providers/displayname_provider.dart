import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final NotifierProvider<DisplayNameNotifier, String> displayNameProvider =
    NotifierProvider<DisplayNameNotifier, String>(DisplayNameNotifier.new);

class DisplayNameNotifier extends Notifier<String> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // In the build function we set the initial value for the display name:
  // 1. It's Sneak Peeker, for anonymous users.
  // 2. It's New Boxer, for newly created accounts.
  // 3. It's the user's actual name.
  @override
  String build() {
    final User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      if (currentUser.isAnonymous) {
        return 'Sneak Peeker';
      } else if (currentUser.displayName == null) {
        return 'New Boxer';
      } else {
        return currentUser.displayName!;
      }
    } else {
      return 'Sneak Peeker';
    }
  }

  // Create a function that allows the user to change the display name.
  Future<void> setDisplayName(String displayName) async {
    await _firebaseAuth.currentUser!.updateDisplayName(displayName);
  }
}
