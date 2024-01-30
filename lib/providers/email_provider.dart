import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final NotifierProvider<EmailNotifier, String> emailProvider =
    NotifierProvider<EmailNotifier, String>(EmailNotifier.new);

class EmailNotifier extends Notifier<String> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  String build() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      state = _firebaseAuth.currentUser!.email ?? 'johndoe@email.com';
    });
    return 'johndoe@email.com';
  }

  String setEmail(String email) {
    return state = email;
  }
}
