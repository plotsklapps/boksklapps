import 'package:boksklapps/all_imports.dart';

/// StateNotifierProvider to return user age as String
/// for easier process from Firestore database
final userAgeProvider =
    StateNotifierProvider<UserAgeNotifier, String>((ref) => UserAgeNotifier());

/// UserAgeNotifier class
class UserAgeNotifier extends StateNotifier<String> {
  /// UserAgeNotifier constructor (default: 0)
  UserAgeNotifier() : super('0');

  /// Method to get user's age
  Future<void> getUserAge() async {
    state = await UserAgeRepository().getUserAge();
  }

  /// Method to update user's age
  Future<void> updateUserAge(BuildContext context, String newAge) async {
    await UserAgeRepository().updateUserAge(context, newAge);
    state = newAge;
  }
}

/// UserAgeRepository class
class UserAgeRepository {
  /// Method to get user's age from Firestore
  Future<String> getUserAge() async {
    final userAgeDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    return userAgeDoc.data()!['userAge'].toString();
  }

  /// Method to update user's age to Firestore
  Future<void> updateUserAge(BuildContext context, String newAge) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(<String, String>{'userAge': newAge});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user age: $error');
    }
  }
}
