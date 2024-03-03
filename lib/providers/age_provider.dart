import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final ageProvider = NotifierProvider<AgeNotifier, int>(AgeNotifier.new);

class AgeNotifier extends Notifier<int> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  int build() {
    return 0;
  }

  Future<void> setAge(int newAge) async {
    // Update the user's age in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_firebase.currentUser?.uid)
        .update(<String, int?>{
      'age': newAge,
    });

    // Update the state with the new age.
    state = newAge;
  }

  Future<void> getAge() async {
    // Get the user's age from the Firestore database.
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection('users')
        .doc(_firebase.currentUser?.uid)
        .get();
    final int age = userDoc.data()!['age'] as int;

    // Update the state with the user's age.
    state = age;
  }
}
