import 'package:boksklapps/all_imports.dart';

final StateNotifierProvider<TotalTimerNotifier, double> totalTimerProvider =
    StateNotifierProvider<TotalTimerNotifier, double>(
        (StateNotifierProviderRef<TotalTimerNotifier, double> ref) {
  return TotalTimerNotifier();
});

class TotalTimerNotifier extends StateNotifier<double> {
  TotalTimerNotifier() : super(30.0);

  Future<void> getTotalTimer() async {
    state = await TotalTimerRepository().getTotalTimer();
  }

  Future<void> updateTotalTimer(
    double newTotalTime,
  ) async {
    await TotalTimerRepository().updateTotalTimer(
      newTotalTime,
    );
    state = newTotalTime;
  }
}

class TotalTimerRepository {
  // Future method getTotalTimer that returns a double parsed from a String
  // from Firestore database
  Future<double> getTotalTimer() async {
    final DocumentSnapshot<Map<String, dynamic>> totalTimerDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return double.parse(totalTimerDoc.data()!['totalTimer'].toString());
  }

  // Future method updateTotalTimer that updates the totalTimer in the
  // Firestore database with a new String, parsed from a double from the
  // parameter newTotalTime
  Future<void> updateTotalTimer(double newTotalTime) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          <String, String>{'totalTimer': newTotalTime.toStringAsFixed(2)},
        );
      } else {
        return;
      }
    } catch (error) {
      Logger().i(
        'Something went wrong: $error...',
      );
    }
  }
}
