import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final NotifierProvider<DisplayNameNotifier, String> displayNameProvider =
    NotifierProvider<DisplayNameNotifier, String>(DisplayNameNotifier.new);

class DisplayNameNotifier extends Notifier<String> {
  // In the build function we set the initial value for the display name.
  @override
  String build() {
    return 'Sneak Peeker';
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> setDisplayName(String displayName) async {
    await _firebaseAuth.currentUser!.updateDisplayName(displayName);
  }

  String? getDisplayName() {
    final String? displayName = _firebaseAuth.currentUser!.displayName;
    if (displayName == null || displayName.isEmpty) {
      return 'Sneak Peeker';
    } else {
      return displayName;
    }
  }
}
