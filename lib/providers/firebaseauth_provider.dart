import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final NotifierProvider<FirebaseAuthNotifier, FirebaseAuth>
    firebaseAuthProvider = NotifierProvider<FirebaseAuthNotifier, FirebaseAuth>(
  FirebaseAuthNotifier.new,
);

class FirebaseAuthNotifier extends Notifier<FirebaseAuth> {
  @override
  FirebaseAuth build() {
    return FirebaseAuth.instance;
  }
}
