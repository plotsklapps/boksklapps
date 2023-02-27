import 'package:boksklapps/all_imports.dart';

final StateNotifierProvider<SetTimerNotifier, double> setTimerProvider =
    StateNotifierProvider<SetTimerNotifier, double>(
        (StateNotifierProviderRef<SetTimerNotifier, double> ref) {
  return SetTimerNotifier();
});

// Provider that returns a Duration in minutes
final StateProvider<Duration> setTimerDurationProvider =
    StateProvider<Duration>((StateProviderRef<Duration> ref) {
  final double setTimer = ref.watch(setTimerProvider);
  final int setTimerInMinutes = setTimer.toInt();
  return Duration(minutes: setTimerInMinutes);
});

class SetTimerNotifier extends StateNotifier<double> {
  SetTimerNotifier() : super(3.0);

  Future<void> getSetTimer() async {
    state = await SetTimerRepository().getSetTimer();
  }

  Future<void> updateSetTimer(
    double newSetTime,
  ) async {
    await SetTimerRepository().updateSetTimer(
      newSetTime,
    );
    state = newSetTime;
  }
}

class SetTimerRepository {
  // Future method getSetTimer that returns a double parsed from a String
  // from Firestore database
  Future<double> getSetTimer() async {
    final DocumentSnapshot<Map<String, dynamic>> setTimerDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return double.parse(setTimerDoc.data()!['setTimer'].toString());
  }

  // Future method updateSetTimer that updates the setTimer in the
  // Firestore database with a new String, parsed from a double from the
  // parameter newSetTime
  Future<void> updateSetTimer(
    double newSetTime,
  ) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          <String, String>{'setTimer': newSetTime.toStringAsFixed(2)},
        );
      }
    } catch (error) {
      Logger().i(
        'Something went wrong: $error...',
      );
    }
  }
}
