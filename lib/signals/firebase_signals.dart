import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:signals/signals.dart';

// The signals package is used to have certain values available to the
// entire app.
//
// A signal is a value that can be read from and written to
// from anywhere in the app (for example: sSneakPeeker.value = true;).
// These signals begin with the letter 's'.
//
// A computed is a value that is derived from
// other signals and/or computeds. These cannot be changed directly.
// These computeds begin with the letter 'c'.

Signal<User?> sCurrentUser = signal<User?>(FirebaseAuth.instance.currentUser);

Signal<bool> sSneakPeeker = signal<bool>(false);

Computed<bool> cLoggedIn = computed(() {
  return sCurrentUser.value != null;
});

Computed<bool> cEmailVerified = computed(() {
  return sCurrentUser.value?.emailVerified ?? false;
});

Computed<String> cDisplayName = computed(() {
  return sSneakPeeker.value
      ? 'Sneak Peeker'
      : sCurrentUser.value?.displayName ?? 'New Boxer';
});

Signal<String> sEmail = signal<String>('JohnDoe@email.com');

Computed<String> cEmail = computed(() {
  return sSneakPeeker.value
      ? 'JohnDoe@email.com'
      : sCurrentUser.value?.email ?? 'JohnDoe@email.com';
});

Signal<String> sPassword = signal<String>('123456');

Signal<String> sLastVisitDate = signal(
  DateFormat('dd-MM-yyyy').format(DateTime.now()),
);

Computed<String> cLastVisitDate = computed<String>(() {
  return sSneakPeeker.value
      ? DateFormat('dd-MM-yyyy').format(DateTime.now())
      : sLastVisitDate.value;
});

Signal<int> sTotalWorkouts = signal<int>(0);

Signal<int> sAgeInYrs = signal<int>(30);

Signal<int> sHeightInCm = signal<int>(175);

Signal<int> sWeightInKg = signal<int>(75);

Signal<double> sBMI = signal<double>(18.5);

Computed<String> cBMI = computed<String>(() {
  final double bmi = sWeightInKg.value /
      ((sHeightInCm.value / 100) * (sHeightInCm.value / 100));
  return bmi.toStringAsFixed(2);
});
