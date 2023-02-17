import 'package:boksklapps/all_imports.dart';

/// StateNotifierProvider to return user age from Firestore database
final userAgeProvider =
    StateNotifierProvider<UserAgeNotifier, int>((ref) => UserAgeNotifier());

/// UserAgeNotifier class
class UserAgeNotifier extends StateNotifier<int> {
  UserAgeNotifier() : super(0);

  /// Method to get user's age
  Future<void> getUserAge() async {
    state = await UserAgeRepository().getUserAge();
  }

  /// Method to update user's age
  Future<void> updateUserAge(BuildContext context, int newAge) async {
    await UserAgeRepository().updateUserAge(context, newAge);
    state = newAge;
  }
}

/// UserAgeRepository class
class UserAgeRepository {
  /// Method to get user's age from Firestore
  Future<int> getUserAge() async {
    final userAgeDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    return int.tryParse(userAgeDoc.data()?['userAge']?.toString() ?? '0') ?? 0;
  }

  /// Method to update user's age to Firestore
  Future<void> updateUserAge(BuildContext context, int newAge) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'userAge': newAge});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user age: $error');
    }
  }
}
