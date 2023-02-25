import 'package:boksklapps/all_imports.dart';

// StateNotifiierProvider to return user tempo as String
// for easier process from Firestore database
final StateNotifierProvider<UserTempoNotifier, String> userTempoProvider =
    StateNotifierProvider<UserTempoNotifier, String>(
        (StateNotifierProviderRef<UserTempoNotifier, String> ref) {
  return UserTempoNotifier();
});

class UserTempoNotifier extends StateNotifier<String> {
  UserTempoNotifier() : super('2.0');

  // Method to get users tempo from Firestore and change state
  Future<void> getUserTempo() async {
    state = await UserTempoRepository().getUserTempo();
  }

  // Method to update users tempo to Firestore and change state
  Future<void> updateUserTempo(
    BuildContext context,
    WidgetRef ref,
    String newTempo,
  ) async {
    await UserTempoRepository().updateUserTempo(
      context,
      ref,
      newTempo,
    );
    state = newTempo;
  }
}

class UserTempoRepository {
  // Method to get users tempo from Firestore
  Future<String> getUserTempo() async {
    // Only get tempo if user is logged in
    if (FirebaseAuth.instance.currentUser != null) {
      final DocumentSnapshot<Map<String, dynamic>> userTempoDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
      return userTempoDoc.data()!['userTempo'].toString();
    } else {
      // Return default tempo if user is not logged in
      return '2.0';
    }
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
      } else {
        return;
      }
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user tempo: $error');
    }
  }

  // Method to convert users tempo from Firestore to double
  double convertTempoStringToDouble(String tempoString) {
    if (tempoString == '1.0') {
      return 1.0;
    } else if (tempoString == '2.0') {
      return 2.0;
    } else if (tempoString == '3.0') {
      return 3.0;
    } else {
      return 4.0;
    }
  }
}
