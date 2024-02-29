import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final ageProvider = NotifierProvider<AgeNotifier, int>(AgeNotifier.new);

class AgeNotifier extends Notifier<int> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  @override
  int build() {
    return 0;
  }

  Future<void> setAge(int newAge) async {
    // Update the user's age in the Firestore database.
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .update(<String, int?>{
      'age': newAge,
    });

    // Update the state with the new age.
    state = newAge;
  }

  Future<void> getAge() async {
    // Get the user's age from the Firestore database.
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_authService.currentUser?.uid)
            .get();
    final int age = userDoc.data()!['age'] as int;

    // Update the state with the user's age.
    state = age;
  }
}

// ignore: always_specify_types
final heightProvider =
    NotifierProvider<HeightNotifier, int>(HeightNotifier.new);

class HeightNotifier extends Notifier<int> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  int build() {
    return 0;
  }

  Future<void> setHeight(int newHeight) async {
    // Update the user's height in the Firestore database.
    await FirebaseFirestore.instance
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
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_authService.currentUser?.uid)
            .get();
    final int height = userDoc.data()!['height'] as int;

    // Update the state with the user's height.
    state = height;
  }
}

// ignore: always_specify_types
final weightProvider =
    NotifierProvider<WeightNotifier, int>(WeightNotifier.new);

class WeightNotifier extends Notifier<int> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  int build() {
    return 0;
  }

  Future<void> setWeight(int newWeight) async {
    // Update the user's weight in the Firestore database.
    await FirebaseFirestore.instance
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
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_authService.currentUser?.uid)
            .get();
    final int weight = userDoc.data()!['weight'] as int;

    // Update the state with the user's weight.
    state = weight;
  }
}

// ignore: always_specify_types
final bmiProvider = NotifierProvider<BMINotifier, double>(BMINotifier.new);

class BMINotifier extends Notifier<double> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  double build() {
    return 0;
  }

  Future<void> setBMI(double newBMI) async {
    final double height = ref.watch(heightProvider) / 100;
    final int weight = ref.watch(weightProvider);
    final double calculatedBMI = weight / (height * height);

    // Update the user's BMI in the Firestore database.
    await FirebaseFirestore.instance
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
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_authService.currentUser?.uid)
            .get();
    final double bmi = userDoc.data()!['bmi'] as double;

    // Update the state with the user's BMI.
    state = bmi;
  }
}
