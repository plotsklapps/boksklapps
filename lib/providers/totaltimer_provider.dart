import 'package:boksklapps/all_imports.dart';

// StateNotifierProvider to return totalTimer duration as
// Duration for easier process from Firestore database
final totalTimerProvider = StateNotifierProvider<TotalTimerNotifier, String>(
  (StateNotifierProviderRef<TotalTimerNotifier, String> ref) {
    return TotalTimerNotifier();
  },
);

class TotalTimerNotifier extends StateNotifier<String> {
  TotalTimerNotifier() : super('30');

  // Method to get totalTimerDuration
  Future<void> getTotalTimerDuration() async {
    state = await TotalTimerRepository().getTotalTimerDuration();

    // The code below, parses the String to Duration, but I do not
    // need do to it here, I need the String for now.

    // Duration duration = Duration(
    //   hours: int.parse(totalTimeDurationAsString.substring(0, 2)),
    //   minutes: int.parse(totalTimeDurationAsString.substring(3, 5)),
    //   seconds: int.parse(totalTimeDurationAsString.substring(6, 8)),
    // );
  }

  // Method to update totalTimerDuration
  Future<void> updateTotalTimerDuration(
    BuildContext context,
    WidgetRef ref,
    String totalTimerDuration,
  ) async {
    await TotalTimerRepository().updateTotalTimerDuration(
      totalTimerDuration,
    );
    state = totalTimerDuration;
  }
}

class TotalTimerRepository {
  // Method to get totalTimerDuration
  Future<String> getTotalTimerDuration() async {
    final DocumentSnapshot<Map<String, dynamic>> totalTimerDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return totalTimerDoc
        .data()!['totalTimerDuration']
        .toString()
        .substring(0, 7);
  }

  // Method to set totalTimerDuration
  Future<void> updateTotalTimerDuration(String totalTimerDuration) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(<String, String>{
      'totalTimerDuration': totalTimerDuration,
    });
  }
}
