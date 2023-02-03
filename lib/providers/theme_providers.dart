import 'package:boksklapps/all_imports.dart';

/// Light Theme Provider
final lightThemeProvider = StateProvider<ThemeData>((ref) {
  return themeLight;
});

/// Dark Theme Provider
final darkThemeProvider = StateProvider<ThemeData>((ref) {
  return themeDark;
});

/// ThemeMode Provider
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.light;
});

/// ThemeModeString Provider
final StateNotifierProvider<ThemeModeString, String> themeModeStringProvider =
// ignore: always_specify_types
    StateNotifierProvider<ThemeModeString, String>((ref) {
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
