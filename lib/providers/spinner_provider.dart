import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final NotifierProvider<SpinnerNotifier, Widget> spinnerProvider =
    NotifierProvider<SpinnerNotifier, Widget>(SpinnerNotifier.new);

class SpinnerNotifier extends Notifier<Widget> {
  @override
  Widget build() {
    return const CircularProgressIndicator(strokeWidth: 6);
  }

  void startSpinner() {
    state = const CircularProgressIndicator(strokeWidth: 6);
  }

  void cancelSpinner() {
    state = const FaIcon(FontAwesomeIcons.forwardStep);
  }
}
