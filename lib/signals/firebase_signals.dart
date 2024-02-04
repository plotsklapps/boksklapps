import 'package:firebase_auth/firebase_auth.dart';
import 'package:signals/signals.dart';

// Create a signal that returns an instance of the current user.
Signal<User?> sCurrentUser = signal<User?>(FirebaseAuth.instance.currentUser);

// Create a signal that returns true if the user is logged in.
Computed<bool> cLoggedIn = computed(() {
  return sCurrentUser.value != null;
});

// Create a signal that returns true if the user is a sneak peeker.
Signal<bool> sSneakPeeker = signal<bool>(false);

// Compute a signal that reacts to changes inside sSneakPeeker
// and/or sCurrentUser signals. Intended for initial use.
Computed<String> cDisplayName = computed(() {
  return sSneakPeeker.value
      ? 'Sneak Peeker'
      : sCurrentUser.value?.displayName ?? 'New Boxer';
});

// Create a signal that is adjustable inside the app by the user.
Signal<String> sDisplayName = signal(cDisplayName.value);

// Compute a signal that returns true if the user is a verified email
// user.
Computed<bool> cEmailVerified = computed(() {
  return sCurrentUser.value?.emailVerified ?? false;
});

Computed<String> cEmail = computed(() {
  return sSneakPeeker.value
      ? 'JohnDoe@email.com'
      : sCurrentUser.value?.email ?? 'JohnDoe@email.com';
});
