import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

Signal<bool> sShowSpinner = signal<bool>(false);

Computed<Widget> cShowSpinner = computed(() {
  return sShowSpinner.value
      ? const CircularProgressIndicator(strokeWidth: 6)
      : const FaIcon(FontAwesomeIcons.forwardStep);
});
