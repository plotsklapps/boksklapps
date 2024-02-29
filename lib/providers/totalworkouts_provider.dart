import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final totalWorkoutsProvider =
    NotifierProvider<TotalWorkoutNotifier, int>(TotalWorkoutNotifier.new);

class TotalWorkoutNotifier extends Notifier<int> {
  // Create an instance of the FirebaseAuth service.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirebaseFirestore class.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  int build() {
    return 0;
  }

  Future<void> setTotalWorkouts() async {
    // Update the user's total workouts in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .update(<String, int?>{
      'totalWorkouts': ref.watch(totalWorkoutsProvider) + 1,
    });

    // Update the state with the new amount.
    state = ref.watch(totalWorkoutsProvider) + 1;
  }

  Future<void> getTotalWorkouts() async {
    // Get the user's total workouts from the Firestore database.
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .get();
    final int totalWorkouts = userDoc.data()!['totalWorkouts'] as int;

    // Update the state with the user's total workouts.
    state = totalWorkouts;
  }
}
