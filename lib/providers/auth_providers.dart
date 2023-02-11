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
