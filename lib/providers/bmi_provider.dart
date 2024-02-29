import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:boksklapps/providers/height_provider.dart';
import 'package:boksklapps/providers/weight_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final bmiProvider = NotifierProvider<BMINotifier, double>(BMINotifier.new);

class BMINotifier extends Notifier<double> {
  // Create an instance of the FirebaseAuth service.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirebaseFirestore class.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  double build() {
    return 0;
  }

  Future<void> setBMI() async {
    final double height = ref.watch(heightProvider) / 100;
    final int weight = ref.watch(weightProvider);
    final double calculatedBMI = weight / (height * height);

    // Update the user's BMI in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .update(<String, double?>{
      'bmi': calculatedBMI,
    });

    // Update the state with the new BMI.
    state = calculatedBMI;
  }

  Future<void> getBMI() async {
    // Get the user's BMI from the Firestore database.
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .get();
    final double bmi = userDoc.data()!['bmi'] as double;

    // Update the state with the user's BMI.
    state = bmi;
  }
}
