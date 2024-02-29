import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final weightProvider =
    NotifierProvider<WeightNotifier, int>(WeightNotifier.new);

class WeightNotifier extends Notifier<int> {
  // Create an instance of the FirebaseAuth service.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirebaseFirestore class.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  int build() {
    return 0;
  }

  Future<void> setWeight(int newWeight) async {
    // Update the user's weight in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .update(<String, int?>{
      'weight': newWeight,
    });

    // Update the state with the new weight.
    state = newWeight;
  }

  Future<void> getWeight() async {
    // Get the user's weight from the Firestore database.
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .get();
    final int weight = userDoc.data()!['weight'] as int;

    // Update the state with the user's weight.
    state = weight;
  }
}
