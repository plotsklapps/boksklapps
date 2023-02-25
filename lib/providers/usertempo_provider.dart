import 'package:boksklapps/all_imports.dart';

// StateNotifiierProvider to return user tempo as String
// for easier process from Firestore database
final StateNotifierProvider<UserTempoNotifier, String> userTempoProvider =
    StateNotifierProvider<UserTempoNotifier, String>(
        (StateNotifierProviderRef<UserTempoNotifier, String> ref) {
  return UserTempoNotifier();
});

class UserTempoNotifier extends StateNotifier<String> {
  UserTempoNotifier() : super('Moderate');

  // Method to get users tempo from Firestore and change state
  Future<void> getUserTempo() async {
    final String tempoString = await UserTempoRepository().getUserTempo();
    state = UserTempoRepository().convertTempoDoubleToString(
      UserTempoRepository().convertTempoStringToDouble(
        tempoString,
      ),
    );
  }

  // Method to update users tempo to Firestore and change state
  Future<String> updateUserTempo(
    BuildContext context,
    WidgetRef ref,
    String newTempo,
  ) async {
    try {
      final String newTempoString = UserTempoRepository()
          .convertTempoStringToDouble(newTempo)
          .toStringAsFixed(1);
      if (FirebaseAuth.instance.currentUser != null) {
        await UserTempoRepository().updateUserTempo(
          context,
          ref,
          newTempoString,
        );
      }
      state = newTempo;
      return newTempo;
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user tempo: $error');
      rethrow;
    }
  }
}

class UserTempoRepository {
  // Method to get users tempo from Firestore
  Future<String> getUserTempo() async {
    try {
      // Only get tempo if user is logged in
      if (FirebaseAuth.instance.currentUser != null) {
        final DocumentSnapshot<Map<String, dynamic>> userTempoDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get();

        // Set returned String to a variable
        return userTempoDoc.data()!['userTempo'].toString();
      }
    } catch (error) {
      // Handle errors here
      Logger().i('Error getting user tempo: $error');
    }
    return 'Moderate';
  }

  // Method to update users tempo to Firestore
  Future<void> updateUserTempo(
    BuildContext context,
    WidgetRef ref,
    String newTempo,
  ) async {
    try {
      // Only update tempo if user is logged in
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(<String, String>{'userTempo': newTempo});
      }
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user tempo: $error');
      rethrow;
    }
  }

  String convertTempoDoubleToString(double tempoDouble) {
    if (tempoDouble == 1.0) {
      return 'Easy';
    } else if (tempoDouble == 2.0) {
      return 'Moderate';
    } else if (tempoDouble == 3.0) {
      return 'Fast';
    } else {
      return 'Ridiculous';
    }
  }

  double convertTempoStringToDouble(String tempoString) {
    if (tempoString == 'Easy') {
      return 1.0;
    } else if (tempoString == 'Moderate') {
      return 2.0;
    } else if (tempoString == 'Fast') {
      return 3.0;
    } else {
      return 4.0;
    }
  }
}
