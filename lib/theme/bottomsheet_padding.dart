import 'package:flutter/material.dart';

EdgeInsets bottomSheetPadding(BuildContext context) {
  return EdgeInsets.fromLTRB(
    16,
    0,
    16,
    MediaQuery.viewInsetsOf(context).bottom + 16,
  );
}
