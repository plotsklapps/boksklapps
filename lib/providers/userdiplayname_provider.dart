import 'package:boksklapps/all_imports.dart';

// StateNotifierProvider to return users displayName as String
// for easier process from Firestore database
final StateNotifierProvider<UserDisplayNameNotifier, String>
    userDisplayNameProvider =
    StateNotifierProvider<UserDisplayNameNotifier, String>(
  (StateNotifierProviderRef<UserDisplayNameNotifier, String> ref) =>
      UserDisplayNameNotifier(),
);

class UserDisplayNameNotifier extends StateNotifier<String> {
  UserDisplayNameNotifier() : super('Sneak Peeker');

  // Method to get users displayName
  Future<void> getUserDisplayName() async {
    state = await UserDisplayNameRepository().getUserDisplayName();
  }

  // Method to update users displayName
  Future<void> updateUserDisplayName(
    BuildContext context,
    WidgetRef ref,
    String newDisplayName,
  ) async {
    await UserDisplayNameRepository()
        .updateUserDisplayName(context, ref, newDisplayName);
    state = newDisplayName;
  }
}

class UserDisplayNameRepository {
  // Method to get users displayName from Firestore
  Future<String> getUserDisplayName() async {
    final DocumentSnapshot<Map<String, dynamic>> userDisplayNameDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return userDisplayNameDoc.data()!['userName'].toString();
  }

  // Method to update users displayName to Firestore
  Future<void> updateUserDisplayName(
    BuildContext context,
    WidgetRef ref,
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
