import 'package:boksklapps/main.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSnackBars {
  static void showError(WidgetRef ref, String message) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: ref.watch(themeProvider.notifier).isDark
                ? flexSchemeDark.onError
                : flexSchemeLight.onError,
          ),
        ),
        showCloseIcon: true,
        backgroundColor: ref.watch(themeProvider.notifier).isDark
            ? flexSchemeDark.error
            : flexSchemeLight.error,
      ),
    );
  }

  static void showSuccess(WidgetRef ref, String message) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        showCloseIcon: true,
      ),
    );
  }
}
