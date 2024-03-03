import 'package:flutter/material.dart';

// Returns padding for the bottomsheets, to keep things consistent.
EdgeInsets bottomSheetPadding(BuildContext context) {
  return EdgeInsets.fromLTRB(
    16,
    0,
    16,
    MediaQuery.viewInsetsOf(context).bottom + 16,
  );
}
