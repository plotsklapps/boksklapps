import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final displayNameProvider =
    NotifierProvider<DisplayNameNotifier, String>(DisplayNameNotifier.new);

class DisplayNameNotifier extends Notifier<String> {
  // Create an instance of the FirebaseAuth service.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirebaseFirestore class.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  String build() {
    return '';
  }

  Future<void> setDisplayName(String newDisplayName) async {
    // Update the user's display name in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .update(<String, String?>{
      'displayName': newDisplayName,
    });

    // Update the state with the new display name.
    state = newDisplayName;
  }

  Future<void> getDisplayName() async {
    // Get the user's display name from the Firestore database.
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .get();
    final String displayName = userDoc.data()!['displayName'] as String;

    // Update the state with the user's display name.
    state = displayName;
  }
}
