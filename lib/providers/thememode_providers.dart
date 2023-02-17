import 'package:boksklapps/all_imports.dart';

/// ThemeMode Provider provides Light, Dark or System theme. Standard to light.
final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((StateProviderRef<ThemeMode> ref) {
  return ThemeMode.light;
});

/// ThemeModeString Provider provides the String which is used in the
/// settings_screen to show the user which theme is currently active.
final StateNotifierProvider<ThemeModeString, String> themeModeStringProvider =
    StateNotifierProvider<ThemeModeString, String>(
        (StateNotifierProviderRef<ThemeModeString, String> ref) {
  return ThemeModeString();
});

/// ThemeModeString class
class ThemeModeString extends StateNotifier<String> {
  /// ThemeModeString constructor
  ThemeModeString() : super('System');

  /// If return value is System, put that in state
  void setThemeModeStringSystem() {
    state = 'System';
  }

  /// If return value is Light, put that in state
  void setThemeModeStringLight() {
    state = 'Light';
  }

  /// If return value is Dark, put that in state
  void setThemeModeStringDark() {
    state = 'Dark';
  }
}
