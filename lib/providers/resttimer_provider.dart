import 'package:boksklapps/all_imports.dart';

final StateNotifierProvider<RestTimerNotifier, double> restTimerProvider =
    StateNotifierProvider<RestTimerNotifier, double>(
        (StateNotifierProviderRef<RestTimerNotifier, double> ref) {
  return RestTimerNotifier();
});

class RestTimerNotifier extends StateNotifier<double> {
  RestTimerNotifier() : super(30.0);

  Future<void> getRestTimer() async {
    state = await RestTimerRepository().getRestTimer();
  }

  Future<void> updateRestTimer(
    double newRestTime,
  ) async {
    await RestTimerRepository().updateRestTimer(
      newRestTime,
    );
    state = newRestTime;
  }
}

class RestTimerRepository {
  // Future method getRestTimer that returns a double parsed from a String
  // from Firestore database
  Future<double> getRestTimer() async {
    final DocumentSnapshot<Map<String, dynamic>> restTimerDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return double.parse(restTimerDoc.data()!['restTimer'].toString());
  }

  // Future method updateSetTimer that updates the setTimer in the
  // Firestore database with a new String, parsed from a double from the
  // parameter
  Future<void> updateRestTimer(
    double newRestTime,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      <String, String>{'restTimer': newRestTime.toStringAsFixed(2)},
    );
  }
}
