import 'package:boksklapps/all_imports.dart';

/// StateNotifierProvider to return user weight as String
/// for easier process from Firestore database
final StateNotifierProvider<UserWeightNotifier, String> userWeightProvider =
    StateNotifierProvider<UserWeightNotifier, String>(
  (StateNotifierProviderRef<UserWeightNotifier, String> ref) =>
      UserWeightNotifier(),
);

/// UserWeightNotifier class
class UserWeightNotifier extends StateNotifier<String> {
  /// UserWeightNotifier constructor (default: 0)
  UserWeightNotifier() : super('0');

  /// Method to get user's weight
  Future<void> getUserWeight() async {
    state = await UserWeightRepository().getUserWeight();
  }

  /// Method to update user's weight
  Future<void> updateUserWeight(BuildContext context, String newWeight) async {
    await UserWeightRepository().updateUserWeight(context, newWeight);
    state = newWeight;
  }
}

/// UserWeightRepository class
class UserWeightRepository {
  /// Method to get user's weight from Firestore
  Future<String> getUserWeight() async {
    final DocumentSnapshot<Map<String, dynamic>> userWeightDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();
    return userWeightDoc.data()!['userWeight'].toString();
  }

  /// Method to update user's weight to Firestore
  Future<void> updateUserWeight(BuildContext context, String newWeight) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(<String, String>{'userWeight': newWeight});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user weight: $error');
    }
  }
}
