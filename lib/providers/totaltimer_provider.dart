import 'package:boksklapps/all_imports.dart';

// totalTimerProvider watches totalTimerNotifier, to have
// access to current state, but also be able to edit it
// in TimerWidget() via + and - buttons
final StateProvider<Duration> totalTimerProvider =
    StateProvider<Duration>((StateProviderRef<Duration> ref) {
  return ref.watch(totalTimerNotifier);
});

// StateNotifierProvider to return totalTimer duration as
// Duration for easier process in UI in TimerWidget()
final StateNotifierProvider<TotalTimerNotifier, Duration> totalTimerNotifier =
    StateNotifierProvider<TotalTimerNotifier, Duration>(
  (StateNotifierProviderRef<TotalTimerNotifier, Duration> ref) {
    return TotalTimerNotifier();
  },
);

class TotalTimerNotifier extends StateNotifier<Duration> {
  // Set default for totalTimerNotifier to 30 minutes
  TotalTimerNotifier() : super(const Duration(minutes: 30));

  // Method to get totalTimerDuration from Firestore database
  Future<void> getTotalTimerDuration() async {
    state = await TotalTimerRepository().getTotalTimerDuration();
  }

  // Method takes a Duration() and sets state to String after
  // being formatted. Then updates Firestore database with
  // this new String
  Future<void> updateTotalTimerDuration(
    BuildContext context,
    WidgetRef ref,
    Duration totalTimerDuration,
  ) async {
    // Format the timer states
    String format(Duration d) {
      return d.toString().split('.').first.padLeft(8, '0');
    }

    // Set formatted timer states in new variables
    final String formattedTotalTime = format(
      ref.watch(totalTimerNotifier),
    );

    // update formattedTotalTime to totalTimerDuration field
    // in Firestore database
    await TotalTimerRepository().updateTotalTimerDuration(
      formattedTotalTime,
    );
    state = totalTimerDuration;
  }
}

class TotalTimerRepository {
  // Method to get totalTimerDuration as String from Firestore and
  // converts it to a Duration() for storing in totalTimerNotifier
  Future<Duration> getTotalTimerDuration() async {
    final DocumentSnapshot<Map<String, dynamic>> totalTimerDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    // Store value retrieved from Firestore into String totalTimerString
    final String totalTimerString =
        totalTimerDoc.data()!['totalTimerDuration'].toString().substring(0, 7);

    // Convert String totalTimerString to a Duration() as requested by
    // Future<Duration>
    final Duration totalTimerDuration = Duration(
      hours: int.parse(totalTimerString.substring(0, 2)),
      minutes: int.parse(totalTimerString.substring(3, 5)),
      seconds: int.parse(
        totalTimerString.substring(6, 8),
      ),
    );

    return totalTimerDuration;
  }

  // Method to set totalTimerDuration and store it to Firestore database
  Future<void> updateTotalTimerDuration(String formattedTotalTime) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(<String, String>{
      'totalTimerDuration': formattedTotalTime,
    });
  }
}
