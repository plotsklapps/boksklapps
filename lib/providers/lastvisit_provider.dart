import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// ignore: always_specify_types
final lastVisitProvider =
    NotifierProvider<LastVisitNotifier, String>(LastVisitNotifier.new);

class LastVisitNotifier extends Notifier<String> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  String build() {
    final String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return today;
  }

  Future<void> setLastVisit() async {
    // Convert the current DateTime to a String.
    final String newLastVisit = DateFormat('dd-MM-yyyy').format(DateTime.now());

    // Update the user's last visit in the Firestore database.
    await _firestore
        .collection('users')
        .doc(_firebase.currentUser?.uid)
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
        .doc(_firebase.currentUser?.uid)
        .get();
    final String lastVisit = userDoc.data()!['lastVisit'] as String;

    // Update the state with the user's last visit date.
    state = lastVisit;
  }
}
