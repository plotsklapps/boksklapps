import 'package:boksklapps/all_imports.dart';

// StateNotifierProvider to return restTimer duration as
// Duration for easier process in UI in TimerWidget()
final StateNotifierProvider<RestTimerNotifier, Duration> restTimerProvider =
    StateNotifierProvider<RestTimerNotifier, Duration>(
  (StateNotifierProviderRef<RestTimerNotifier, Duration> ref) {
    return RestTimerNotifier();
  },
);

class RestTimerNotifier extends StateNotifier<Duration> {
  // Set default for restTimerNotifier to 30 minutes
  RestTimerNotifier() : super(const Duration(seconds: 3));

  // Method to get restTimerDuration from Firestore database
  Future<void> getRestTimerDuration() async {
    state = await RestTimerRepository().getRestTimerDuration();
  }

  // Method takes a Duration() and sets state to String after
  // being formatted. Then updates Firestore database with
  // this new String
  Future<void> updateRestTimerDuration(
    BuildContext context,
    WidgetRef ref,
    Duration restTimerDuration,
  ) async {
    // Format the timer states
    String format(Duration d) {
      return d.toString().split('.').first.padLeft(8, '0');
    }

    // Set formatted timer states in new variables
    final String formattedRestTime = format(
      ref.watch(restTimerProvider),
    );

    // update formattedRestTime to restTimerDuration field
    // in Firestore database
    await RestTimerRepository().updateRestTimerDuration(
      formattedRestTime,
    );
    state = restTimerDuration;
  }
}

class RestTimerRepository {
  // Method to get restTimerDuration as String from Firestore and
  // converts it to a Duration() for storing in restTimerNotifier
  Future<Duration> getRestTimerDuration() async {
    final DocumentSnapshot<Map<String, dynamic>> restTimerDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    // Store value retrieved from Firestore into String restTimerString
    final String restTimerString =
        restTimerDoc.data()!['restTimer'].toString().substring(0, 7);

    // Convert String restTimerString to a Duration() as requested by
    // Future<Duration>
    final Duration restTimerDuration = Duration(
      hours: int.parse(restTimerString.substring(0, 2)),
      minutes: int.parse(restTimerString.substring(3, 5)),
      seconds: int.parse(
        restTimerString.substring(6, 8),
      ),
    );

    return restTimerDuration;
  }

  // Method to set restTimerDuration and store it to Firestore database
  Future<void> updateRestTimerDuration(String formattedRestTime) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(<String, String>{
      'restTimer': formattedRestTime,
    });
  }
}
