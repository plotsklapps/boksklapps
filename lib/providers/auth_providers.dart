import 'package:boksklapps/all_imports.dart';

/// Returns instance of FirebaseAuth
final StateProvider<FirebaseAuth> firebaseProvider =
    StateProvider<FirebaseAuth>((StateProviderRef<FirebaseAuth> ref) {
  return FirebaseAuth.instance;
});

/// Returns instance of User
final StateProvider<User?> currentUserProvider =
    StateProvider<User?>((StateProviderRef<User?> ref) {
  return FirebaseAuth.instance.currentUser;
});

/// Returns current user's email as String
final StateProvider<String?> currentEmailProvider =
    StateProvider<String?>((StateProviderRef<String?> ref) {
  return FirebaseAuth.instance.currentUser!.email!;
});

/// BoksklappsUser class
class BoksklappsUser {
  /// BoksklappsUser constructor
  BoksklappsUser({
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userAge,
    required this.userHeight,
    required this.userWeight,
    required this.userBMI,
  });

  /// Draw data from Firestore Collection
  factory BoksklappsUser.fromFirestore() => BoksklappsUser(
        userId: '',
        userEmail: '',
        userName: '',
        userAge: 0,
        userHeight: 0,
        userWeight: 0,
        userBMI: 0.0,
      );
  String userId;
  String userEmail;
  String userName;
  int userAge;
  int userHeight;
  int userWeight;
  double userBMI;

  /// Send data to Firestore Collection
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
      'userAge': userAge,
      'userHeight': userHeight,
      'userWeight': userWeight,
      'userBMI': userBMI,
    };
  }
}
