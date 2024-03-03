import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final displayNameProvider =
    NotifierProvider<DisplayNameNotifier, String>(DisplayNameNotifier.new);

class DisplayNameNotifier extends Notifier<String> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  String build() {
    if (ref.watch(sneakPeekProvider) == true) {
      return 'Sneak Peeker';
    } else {
      return 'New Boxer';
    }
  }

  Future<void> setDisplayName(String newDisplayName) async {
    // Update the user's display name in Firebase Authentication.
    await _firebase.currentUser?.updateDisplayName(newDisplayName);

    // Update the user's display name in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_firebase.currentUser?.uid)
        .update(<String, String?>{
      'displayName': newDisplayName,
    });

    // Update the state with the new display name.
    state = newDisplayName;
  }

  Future<void> getDisplayName() async {
    // Get the user's displayName from Firebase Authentication.
    final String displayName =
        _firebase.currentUser?.displayName ?? 'New Boxer';

    // Update the state with the user's display name.
    state = displayName;
  }
}
