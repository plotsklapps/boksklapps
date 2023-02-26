import 'package:boksklapps/all_imports.dart';

// TODO: Start over. This is not the way to do it.
// Now I'm converting from String to double and back to String
// to make sure it is in the correct format
// (e.g. 'Moderate' instead of '2.0'). I should just use
// double and convert to String when I need to.s

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
    // First fetch tempo from Firestore or set to default
    final String tempoString = await UserTempoRepository().getUserTempo();
    // Then convert tempo from String to double and back to String
    // to make sure it is in the correct format (e.g. 'Moderate'
    // instead of '2.0')
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
      // First convert tempo from double to String
      final String newTempoString = UserTempoRepository()
          .convertTempoStringToDouble(newTempo)
          .toStringAsFixed(1);
      // Then update tempo in Firestore if user is logged in
      if (FirebaseAuth.instance.currentUser != null) {
        await UserTempoRepository().updateUserTempo(
          context,
          ref,
          newTempoString,
        );
      }
      // Finally change state to new tempo
      state = newTempo;
      // Return new tempo to be used in other methods
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
      // Tempo is stored as a String in Firestore
      // as '2.0' instead of 'Moderate' for example
      if (FirebaseAuth.instance.currentUser != null) {
        Logger().i(
          'Updating user tempo to Firestore: $newTempo',
        );
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

  // Method to convert tempo from double to formatted String
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

  // Method to convert tempo from formatted String to double
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
