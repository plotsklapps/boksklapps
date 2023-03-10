import 'package:boksklapps/all_imports.dart';

// Provider that returns a Duration in minutes which is altered
// in a timer in workout_screen
final StateProvider<Duration> userTempoDurationProvider =
    StateProvider<Duration>((StateProviderRef<Duration> ref) {
  final Map<double, Duration> tempoDurations = <double, Duration>{
    1.0: const Duration(milliseconds: 1500), //1.5 seconds
    2.0: const Duration(milliseconds: 1000), //1.0 seconds
    3.0: const Duration(milliseconds: 750), // 0.8 seconds
    4.0: const Duration(milliseconds: 500), // 0.5 seconds
  };

  // Return the corresponding Duration for the tempo value
  return tempoDurations[ref.watch(userTempoProvider)] ??
      const Duration(milliseconds: 1000);
});

// StateNotifierProvider for the users tempo returning a double
final StateNotifierProvider<UserTempoNotifier, double> userTempoProvider =
    StateNotifierProvider<UserTempoNotifier, double>(
  (StateNotifierProviderRef<UserTempoNotifier, double> ref) =>
      UserTempoNotifier(),
);

class UserTempoNotifier extends StateNotifier<double> {
  // Return default double value of 2.0
  UserTempoNotifier() : super(2.0);

  // Get users tempo from UserTempoRepository.getUserTempo()
  // set state and return a double
  Future<double> getUserTempo() async {
    final double userTempo = await UserTempoRepository().getUserTempo();
    state = userTempo;
    return userTempo;
  }

  // Update users tempo to UserTempoRepository.updateUserTempo()
  // set state and return a double
  Future<double> updateUserTempo(
    BuildContext context,
    WidgetRef ref,
    double newUserTempo,
  ) async {
    await UserTempoRepository().updateUserTempo(
      context,
      ref,
      newUserTempo,
    );
    state = newUserTempo;
    return newUserTempo;
  }
}

class UserTempoRepository {
  // Get users tempo from Firestore and return a double
  Future<double> getUserTempo() async {
    final DocumentSnapshot<Map<String, dynamic>> userTempoDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    try {
      return double.parse(
        userTempoDoc.get('userTempo').toString(),
      );
    } catch (error) {
      Logger().i(
        'Something went wrong... $error',
      );
      rethrow;
    }
  }

  // Update users tempo to Firestore as double
  Future<void> updateUserTempo(
    BuildContext context,
    WidgetRef ref,
    double newUserTempo,
  ) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(<String, double>{
          'userTempo': newUserTempo,
        });
      }
    } catch (error) {
      Logger().i(
        'Something went wrong... $error',
      );
      // Show snackbar to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong... $error',
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  String getTempoLabel(WidgetRef ref, double tempo) {
    // Define a map that maps tempo values to label strings
    final Map<double, String> tempoLabels = <double, String>{
      1.0: 'Easy',
      2.0: 'Moderate',
      3.0: 'Fast',
      4.0: 'Ridiculous',
    };

    // Return the corresponding label string for the tempo value
    return tempoLabels[tempo] ??
        ref.watch(userTempoProvider).toStringAsFixed(1);
  }
}
