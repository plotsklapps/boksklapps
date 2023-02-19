import 'package:boksklapps/all_imports.dart';

/// StateNotifierProvider to return user email as String
/// for easier process from Firestore database
final StateNotifierProvider<UserEmailNotifier, String> userEmailProvider =
    StateNotifierProvider<UserEmailNotifier, String>(
  (StateNotifierProviderRef<UserEmailNotifier, String> ref) =>
      UserEmailNotifier(),
);

/// UserEmailNotifier class
class UserEmailNotifier extends StateNotifier<String> {
  /// UserEmailNotifier constructor (default: 'Sneak Peeker' if user
  /// is unknown)
  UserEmailNotifier() : super('Sneak Peeker');

  /// Method to get user's email
  Future<void> getUserEmail() async {
    state = await UserEmailRepository().getUserEmail();
  }

  /// Method to update user's email
  Future<void> updateUserEmail(BuildContext context, String newEmail) async {
    await UserEmailRepository().updateUserEmail(context, newEmail);
    state = newEmail;
  }
}

/// UserEmailRepository class
class UserEmailRepository {
  /// Method to get user's email from Firestore
  Future<String> getUserEmail() async {
    final DocumentSnapshot<Map<String, dynamic>> userEmailDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();
    return userEmailDoc.data()!['userEmail'].toString();
  }

  /// Method to update user's email to Firestore
  Future<void> updateUserEmail(BuildContext context, String newEmail) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(newEmail);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(<String, String>{'userEmail': newEmail});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user email: $error');
    }
  }
}
