import 'package:boksklapps/all_imports.dart';

// setTimerProvider watches setTimerNotifier, to have
// access to current state, but also be able to edit it
// in TimerWidget() via + and - buttons
final StateProvider<Duration> setTimerProvider =
    StateProvider<Duration>((StateProviderRef<Duration> ref) {
  return ref.watch(setTimerNotifier);
});

// StateNotifierProvider to return setTimer duration as
// Duration for easier process in UI in TimerWidget()
final StateNotifierProvider<SetTimerNotifier, Duration> setTimerNotifier =
    StateNotifierProvider<SetTimerNotifier, Duration>(
  (StateNotifierProviderRef<SetTimerNotifier, Duration> ref) {
    return SetTimerNotifier();
  },
);

class SetTimerNotifier extends StateNotifier<Duration> {
  // Set default for setTimerNotifier to 30 minutes
  SetTimerNotifier() : super(const Duration(minutes: 3));

  // Method to get setTimerDuration from Firestore database
  Future<void> getSetTimerDuration() async {
    state = await SetTimerRepository().getSetTimerDuration();
  }

  // Method takes a Duration() and sets state to String after
  // being formatted. Then updates Firestore database with
  // this new String
  Future<void> updateSetTimerDuration(
    BuildContext context,
    WidgetRef ref,
    Duration setTimerDuration,
  ) async {
    // Format the timer states
    String format(Duration d) {
      return d.toString().split('.').first.padLeft(8, '0');
    }

    // Set formatted timer states in new variables
    final String formattedSetTime = format(
      ref.watch(setTimerNotifier),
    );

    // update formattedSetTime to setTimerDuration field
    // in Firestore database
    await SetTimerRepository().updateSetTimerDuration(
      formattedSetTime,
    );
    state = setTimerDuration;
  }
}

class SetTimerRepository {
  // Method to get setTimerDuration as String from Firestore and
  // converts it to a Duration() for storing in setTimerNotifier
  Future<Duration> getSetTimerDuration() async {
    final DocumentSnapshot<Map<String, dynamic>> setTimerDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    // Store value retrieved from Firestore into String setTimerString
    final String setTimerString =
        setTimerDoc.data()!['setTimerDuration'].toString().substring(0, 7);

    // Convert String setTimerString to a Duration() as requested by
    // Future<Duration>
    final Duration setTimerDuration = Duration(
      hours: int.parse(setTimerString.substring(0, 2)),
      minutes: int.parse(setTimerString.substring(3, 5)),
      seconds: int.parse(
        setTimerString.substring(6, 8),
      ),
    );

    return setTimerDuration;
  }

  // Method to set setTimerDuration and store it to Firestore database
  Future<void> updateSetTimerDuration(String formattedSetTime) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(<String, String>{
      'setTimerDuration': formattedSetTime,
    });
  }
}
