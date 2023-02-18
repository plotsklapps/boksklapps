import 'package:boksklapps/all_imports.dart';

/// StateNotifierProvider to return user age as String
/// for easier process from Firestore database
final StateNotifierProvider<UserAgeNotifier, String> userAgeProvider =
    StateNotifierProvider<UserAgeNotifier, String>(
  (StateNotifierProviderRef<UserAgeNotifier, String> ref) => UserAgeNotifier(),
);

/// UserAgeNotifier class
class UserAgeNotifier extends StateNotifier<String> {
  /// UserAgeNotifier constructor (default: 0)
  UserAgeNotifier() : super('0');

  /// Method to get user's age
  Future<void> getUserAge() async {
    state = await UserAgeRepository().getUserAge();
  }

  /// Method to update user's age
  Future<void> updateUserAge(
    BuildContext context,
    WidgetRef ref,
    String newAge,
  ) async {
    await UserAgeRepository().updateUserAge(
      context,
      ref,
      newAge,
    );
    state = newAge;
  }
}

/// UserAgeRepository class
class UserAgeRepository {
  /// Method to get user's age from Firestore
  Future<String> getUserAge() async {
    final DocumentSnapshot<Map<String, dynamic>> getUserAgeDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();
    return getUserAgeDoc.data()!['userAge'].toString();
  }

  /// Method to update user's age to Firestore
  Future<void> updateUserAge(
    BuildContext context,
    WidgetRef ref,
    String newAge,
  ) async {
    try {
      await ref
          .watch(firestoreProvider)
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(<String, String>{'userAge': newAge});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user age: $error');
    }
  }
}
