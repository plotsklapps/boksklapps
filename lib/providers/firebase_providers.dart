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
