import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

Signal<bool> sSpinnerStart = signal<bool>(false);

Computed<Widget> cSpinnerStart = computed(() {
  return sSpinnerStart.value
      ? const CircularProgressIndicator(strokeWidth: 6)
      : const FaIcon(FontAwesomeIcons.forwardStep);
});

Signal<bool> sSpinnerSignup = signal<bool>(false);

Computed<Widget> cSpinnerSignup = computed(() {
  return sSpinnerSignup.value
      ? const CircularProgressIndicator(strokeWidth: 6)
      : const FaIcon(FontAwesomeIcons.forwardStep);
});

Signal<bool> sSpinnerSignin = signal<bool>(false);

Computed<Widget> cSpinnerSignIn = computed(() {
  return sSpinnerSignin.value
      ? const CircularProgressIndicator(strokeWidth: 6)
      : const FaIcon(FontAwesomeIcons.forwardStep);
});

Computed<Widget> cSpinnerSneakPeek = computed(() {
  return sSneakPeeker.value
      ? const CircularProgressIndicator(strokeWidth: 6)
      : const FaIcon(FontAwesomeIcons.forwardStep);
});
