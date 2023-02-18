import 'package:boksklapps/all_imports.dart';

/// StateNotifierProvider to return user BMI as String
/// for easier process from Firestore database
final userBMIProvider = StateNotifierProvider<UserBMINotifier, String>(
  (ref) => UserBMINotifier(),
);

/// UserBMINotifier class
class UserBMINotifier extends StateNotifier<String> {
  /// UserBMINotifier constructor (default: 0)
  UserBMINotifier() : super('Sneak Peeker');

  /// Method to get user's BMI
  Future<void> getUserBMI() async {
    state = await UserBMIRepository().getUserBMI();
  }

  /// Method to update user's BMI
  Future<void> updateUserBMI(BuildContext context, String newBMI) async {
    await UserBMIRepository().updateUserBMI(context, newBMI);
    state = newBMI;
  }
}

/// UserBMIRepository class
class UserBMIRepository {
  /// Method to get user's BMI from Firestore
  Future<String> getUserBMI() async {
    final userBMIDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    final double userBMI =
        double.parse(userBMIDoc.data()!['userBMI'].toString());
    return userBMI.toStringAsFixed(2);
  }

  /// Method to update user's BMI to Firestore
  Future<void> updateUserBMI(BuildContext context, String newBMI) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(<String, String>{'userBMI': newBMI});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user BMI: $error');
    }
  }

  String calculateUserBMI(String height, String weight) {
    final double userHeight = double.parse(height) / 100;
    final double userWeight = double.parse(weight);

    final double calculatedBMI = userWeight / (userHeight * userHeight);

    return calculatedBMI.toStringAsFixed(2);
  }
}
