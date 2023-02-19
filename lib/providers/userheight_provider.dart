import 'package:boksklapps/all_imports.dart';

/// StateNotifierProvider to return user height as String
/// for easier process from Firestore database
final StateNotifierProvider<UserHeightNotifier, String> userHeightProvider =
    StateNotifierProvider<UserHeightNotifier, String>(
        (StateNotifierProviderRef<UserHeightNotifier, String> ref) {
  return UserHeightNotifier();
});

class UserHeightNotifier extends StateNotifier<String> {
  UserHeightNotifier() : super('0');

  Future<void> getUserHeight() async {
    state = await UserHeightRepository().getUserHeight();
  }

  Future<void> updateUserHeight(BuildContext context, String newHeight) async {
    await UserHeightRepository().updateUserHeight(context, newHeight);
    state = newHeight;
  }
}

class UserHeightRepository {
  Future<String> getUserHeight() async {
    final DocumentSnapshot<Map<String, dynamic>> userHeightDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return userHeightDoc.data()!['userHeight'].toString();
  }

  Future<void> updateUserHeight(BuildContext context, String newHeight) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(<String, String>{'userHeight': newHeight});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user height: $error');
    }
  }
}
