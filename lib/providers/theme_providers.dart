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
