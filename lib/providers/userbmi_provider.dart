import 'package:boksklapps/all_imports.dart';

// StateNotifierProvider to return user BMI as String
// for easier process from Firestore database
final StateNotifierProvider<UserBMINotifier, String> userBMIProvider =
    StateNotifierProvider<UserBMINotifier, String>(
  (StateNotifierProviderRef<UserBMINotifier, String> ref) => UserBMINotifier(),
);

class UserBMINotifier extends StateNotifier<String> {
  UserBMINotifier() : super('0.0');

  Future<void> getUserBMI() async {
    state = await UserBMIRepository().getUserBMI();
  }

  Future<void> updateUserBMI(
    BuildContext context,
    WidgetRef ref,
    String newBMI,
  ) async {
    await UserBMIRepository().updateUserBMI(
      context,
      ref,
      newBMI,
    );
    state = newBMI;
  }
}

class UserBMIRepository {
  Future<String> getUserBMI() async {
    final DocumentSnapshot<Map<String, dynamic>> userBMIDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return userBMIDoc.data()!['userBMI'].toString();
  }

  /// Method to update user's BMI to Firestore
  Future<void> updateUserBMI(
    BuildContext context,
    WidgetRef ref,
    String newBMI,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(<String, String>{'userBMI': newBMI});
    } catch (error) {
      // Handle errors here
      Logger().i('Error updating user BMI: $error');
    }
  }

  /// Method to calculate user's BMI according to height and weight
  String calculateUserBMI(String height, String weight) {
    final double userHeight = double.parse(height) / 100;
    final double userWeight = double.parse(weight);

    final double calculatedBMI = userWeight / (userHeight * userHeight);

    return calculatedBMI.toStringAsFixed(2);
  }
}
