import 'package:boksklapps/all_imports.dart';

/// StateNotifierProvider to return user displayName as String
/// for easier process from Firestore database
final StateNotifierProvider<UserDisplayNameNotifier, String>
    userDisplayNameProvider =
    StateNotifierProvider<UserDisplayNameNotifier, String>(
  (StateNotifierProviderRef<UserDisplayNameNotifier, String> ref) =>
      UserDisplayNameNotifier(),
);

/// UserDisplayNameNotifier class
class UserDisplayNameNotifier extends StateNotifier<String> {
  UserDisplayNameNotifier() : super('Sneak Peeker');

  /// Method to get user's displayName
  Future<void> getUserDisplayName() async {
    state = await UserDisplayNameRepository().getUserDisplayName();
  }

  /// Method to update user's displayName
  Future<void> updateUserDisplayName(
    BuildContext context,
    String newDisplayName,
  ) async {
    await UserDisplayNameRepository()
        .updateUserDisplayName(context, newDisplayName);
    state = newDisplayName;
  }
}

/// UserDisplayNameRepository class
class UserDisplayNameRepository {
  /// Method to get user's displayName from Firestore
  Future<String> getUserDisplayName() async {
    final DocumentSnapshot<Map<String, dynamic>> userDisplayNameDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return userDisplayNameDoc.data()!['userName'].toString();
  }

  /// Method to update user's displayName to Firestore
  Future<void> updateUserDisplayName(
    BuildContext context,
    String newDisplayName,
  ) async {
    try {
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(newDisplayName);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(<String, String>{'userName': newDisplayName});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user displayName: $error');
    }
  }
}
