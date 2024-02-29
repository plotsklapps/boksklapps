import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final heightProvider =
    NotifierProvider<HeightNotifier, int>(HeightNotifier.new);

class HeightNotifier extends Notifier<int> {
  // Create an instance of the FirebaseAuth service.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirebaseFirestore class.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  int build() {
    return 0;
  }

  Future<void> setHeight(int newHeight) async {
    // Update the user's height in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .update(<String, int?>{
      'height': newHeight,
    });

    // Update the state with the new height.
    state = newHeight;
  }

  Future<void> getHeight() async {
    // Get the user's height from the Firestore database.
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .get();
    final int height = userDoc.data()!['height'] as int;

    // Update the state with the user's height.
    state = height;
  }
}
