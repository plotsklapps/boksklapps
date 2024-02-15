import 'package:flutter/material.dart';

class TextUtils {
  static const TextStyle fontS = TextStyle(
    fontSize: 12,
  );
  static const TextStyle fontM = TextStyle(
    fontSize: 16,
  );
  static const TextStyle fontL = TextStyle(
    fontSize: 20,
  );
  static const TextStyle fontXL = TextStyle(
    fontSize: 24,
  );
  static const TextStyle fontXXL = TextStyle(
    fontSize: 32,
  );
  // Used to validate email addresses
  static const Pattern regexpPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}
