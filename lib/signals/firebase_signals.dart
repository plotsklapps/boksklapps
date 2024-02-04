import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals/signals.dart';

// Create a signal that returns an instance of the current user.
final Signal<User?> sCurrentUser =
    signal<User?>(FirebaseAuth.instance.currentUser);

// Create a signal that returns true if the user is logged in.
final Computed<bool> sLoggedIn = computed(() {
  return sCurrentUser() != null;
});

// Create a signal that returns true if the user is a sneak peeker.
final Signal<bool> sSneakPeeker = signal<bool>(false);

// Create a signal that returns true if the user is a verified email user.
final Computed<bool> sEmailVerified = computed(() {
  return sCurrentUser()?.emailVerified ?? false;
});

// Create a signal that returns the current user's display name.
final Computed<String> sDisplayName = computed(() {
  if (sSneakPeeker() == true) {
    return 'Sneak Peeker';
  } else {
    return sCurrentUser()?.displayName ?? 'New Boxer';
  }
});

final Computed<String> sEmail = computed(() {
  return sCurrentUser()?.email ?? '';
});

final Signal<String> sLastVisitDate = signal<String>('');
