import '../all_imports.dart';

/// ThemeColor Provider returns a FlexScheme.something to be used in the
/// Light and Dark Theme Providers
final StateNotifierProvider<ThemeColorState, FlexScheme> themeColorProvider =
    StateNotifierProvider<ThemeColorState, FlexScheme>(
        (StateNotifierProviderRef<ThemeColorState, FlexScheme> ref) {
  return ThemeColorState();
});

/// ThemeColorState class
class ThemeColorState extends StateNotifier<FlexScheme> {
  /// ThemeColorState constructor
  ThemeColorState() : super(FlexScheme.outerSpace);

  /// setTheme method for choosing outerSpace
  void setThemeOuterSpace() {
    state = FlexScheme.outerSpace;
  }

  /// setTheme method for choosing greenMoney
  void setThemeGreenMoney() {
    state = FlexScheme.money;
  }

  /// setTheme method for choosing redredWine
  void setThemeRedWine() {
    state = FlexScheme.redWine;
  }
}

/// ThemeColorString Provider provides the String which is used in the
/// settings_screen to show the user which color is currently active.
final StateNotifierProvider<ThemeColorString, String> themeColorStringProvider =
    StateNotifierProvider<ThemeColorString, String>(
        (StateNotifierProviderRef<ThemeColorString, String> ref) {
  return ThemeColorString();
});

/// ThemeColorString class
class ThemeColorString extends StateNotifier<String> {
  /// ThemeColorString constructor
  ThemeColorString() : super('Outer Space');

  /// setThemeColor method for choosing outerSpace
  void setThemeColorStringOuterSpace() {
    state = 'Outer Space';
  }

  /// setThemeColor method for choosing blueDelight
  void setThemeColorStringGreenMoney() {
    state = 'Green Money';
  }

  /// setThemeColor method for choosing redredWine
  void setThemeColorStringRedWine() {
    state = 'Red Red Wine';
  }
}
