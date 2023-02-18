import 'package:boksklapps/all_imports.dart';

/// StateNotifierProvider to return user height as String
/// for easier process from Firestore database
final userHeightProvider = StateNotifierProvider<UserHeightNotifier, String>(
  (ref) => UserHeightNotifier(),
);

/// UserHeightNotifier class
class UserHeightNotifier extends StateNotifier<String> {
  /// UserHeightNotifier constructor (default: 0)
  UserHeightNotifier() : super('0');

  /// Method to get user's height
  Future<void> getUserHeight() async {
    state = await UserHeightRepository().getUserHeight();
  }

  /// Method to update user's height
  Future<void> updateUserHeight(BuildContext context, String newHeight) async {
    await UserHeightRepository().updateUserHeight(context, newHeight);
    state = newHeight;
  }
}

/// UserHeightRepository class
class UserHeightRepository {
  /// Method to get user's height from Firestore
  Future<String> getUserHeight() async {
    final userHeightDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    return userHeightDoc.data()!['userHeight'].toString();
  }

  /// Method to update user's height to Firestore
  Future<void> updateUserHeight(BuildContext context, String newHeight) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(<String, String>{'userHeight': newHeight});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user height: $error');
    }
  }
}
