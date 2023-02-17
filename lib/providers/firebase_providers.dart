import 'package:boksklapps/all_imports.dart';

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
  return ref.watch(firebaseProvider).currentUser;
});

/// Returns current user's email as String
final StateProvider<String?> currentEmailProvider =
    StateProvider<String?>((StateProviderRef<String?> ref) {
  return ref.watch(currentUserProvider)!.email!;
});

/// Returns current user's display name as String
final StateProvider<String?> currentDisplayNameProvider =
    StateProvider<String?>((StateProviderRef<String?> ref) {
  return ref.watch(currentUserProvider)!.displayName!;
});
