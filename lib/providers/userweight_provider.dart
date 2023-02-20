import 'package:boksklapps/all_imports.dart';

// StateNotifierProvider to return users weight as String
// for easier process from Firestore database
final StateNotifierProvider<UserWeightNotifier, String> userWeightProvider =
    StateNotifierProvider<UserWeightNotifier, String>(
        (StateNotifierProviderRef<UserWeightNotifier, String> ref) {
  return UserWeightNotifier();
});

// UserWeightNotifier class
class UserWeightNotifier extends StateNotifier<String> {
  UserWeightNotifier() : super('0');

  // Method to get users weight
  Future<void> getUserWeight() async {
    state = await UserWeightRepository().getUserWeight();
  }

  // Method to update users weight
  Future<void> updateUserWeight(
    BuildContext context,
    WidgetRef ref,
    String newWeight,
  ) async {
    await UserWeightRepository().updateUserWeight(
      context,
      ref,
      newWeight,
    );
    state = newWeight;
  }
}

// UserWeightRepository class
class UserWeightRepository {
  // Method to get users weight from Firestore
  Future<String> getUserWeight() async {
    final DocumentSnapshot<Map<String, dynamic>> userWeightDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return userWeightDoc.data()!['userWeight'].toString();
  }

  // Method to update users weight to Firestore
  Future<void> updateUserWeight(
    BuildContext context,
    WidgetRef ref,
    String newWeight,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(<String, String>{'userWeight': newWeight});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user weight: $error');
    }
  }
}
