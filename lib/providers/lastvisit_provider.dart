import 'package:boksklapps/providers/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// ignore: always_specify_types
final lastVisitProvider =
    NotifierProvider<LastVisitNotifier, String>(LastVisitNotifier.new);

class LastVisitNotifier extends Notifier<String> {
  // Create an instance of the FirebaseAuth service.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirebaseFirestore class.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  String build() {
    return '';
  }

  Future<void> setLastVisit() async {
    // Convert the current DateTime to a String.
    final String newLastVisit = DateFormat('dd-MM-yyyy').format(DateTime.now());

    // Update the user's last visit in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .update(<String, String?>{
      'lastVisit': newLastVisit,
    });

    // Update the state with the new date.
    state = newLastVisit;
  }

  Future<void> getLastVisit() async {
    // Get the user's last visit date from the Firestore database.
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection('users')
        .doc(_authService.currentUser?.uid)
        .get();
    final String lastVisit = userDoc.data()!['lastVisit'] as String;

    // Update the state with the user's last visit date.
    state = lastVisit;
  }
}
