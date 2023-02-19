import 'package:boksklapps/all_imports.dart';

// StateNotifierProvider to return users email as String
// for easier process from Firestore database
final StateNotifierProvider<UserEmailNotifier, String> userEmailProvider =
    StateNotifierProvider<UserEmailNotifier, String>(
        (StateNotifierProviderRef<UserEmailNotifier, String> ref) {
  return UserEmailNotifier();
});

class UserEmailNotifier extends StateNotifier<String> {
  UserEmailNotifier() : super('Sneak Peeker');

  // Method to get users email
  Future<void> getUserEmail() async {
    state = await UserEmailRepository().getUserEmail();
  }

  // Method to update users email
  Future<void> updateUserEmail(BuildContext context, String newEmail) async {
    await UserEmailRepository().updateUserEmail(context, newEmail);
    state = newEmail;
  }
}

class UserEmailRepository {
  // Method to get users email from Firestore
  Future<String> getUserEmail() async {
    final DocumentSnapshot<Map<String, dynamic>> userEmailDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return userEmailDoc.data()!['userEmail'].toString();
  }

  // Method to update user's email to Firestore
  Future<void> updateUserEmail(BuildContext context, String newEmail) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(newEmail);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(<String, String>{'userEmail': newEmail});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user email: $error');
    }
  }
}
