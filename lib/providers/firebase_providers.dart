import '../all_imports.dart';

/// Returns instance of FirebaseAuth
final StateProvider<FirebaseAuth> firebaseProvider =
    StateProvider<FirebaseAuth>((StateProviderRef<FirebaseAuth> ref) {
  return FirebaseAuth.instance;
});

/// Returns instance of FirebaseFirestore
final StateProvider<FirebaseFirestore> firestoreProvider =
    StateProvider<FirebaseFirestore>((StateProviderRef<FirebaseFirestore> ref) {
  return FirebaseFirestore.instance;
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

/// Class that holds Future method to get current user's BMI from Firestore
class CurrentUserBMI extends StateNotifier<String> {
  /// MyStateNotifier constructor
  CurrentUserBMI() : super('0.0') {
    FutureProvider<String>((FutureProviderRef<String> ref) async {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await ref
          .watch(firestoreProvider)
          .collection('users')
          .doc(ref.watch(currentUserProvider)!.uid)
          .get();
      final String userBMI = documentSnapshot.get('userBMI').toString();
      return userBMI;
    });
  }
}

/// Returns current user's BMI as String from Firestore
final StateNotifierProvider<CurrentUserBMI, String> currentBMIProvider =
    StateNotifierProvider<CurrentUserBMI, String>(
        (StateNotifierProviderRef<CurrentUserBMI, String> ref) {
  return CurrentUserBMI();
});
