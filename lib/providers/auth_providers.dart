import 'package:boksklapps/all_imports.dart';

/// Returns instance of FirebaseAuth
final firebaseProvider = StateProvider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Returns instance of User
final currentUserProvider = StateProvider<User?>((ref) {
  return FirebaseAuth.instance.currentUser;
});

/// Returns current user's email as String
final currentEmailProvider = StateProvider<String?>((ref) {
  return FirebaseAuth.instance.currentUser!.email!;
});
