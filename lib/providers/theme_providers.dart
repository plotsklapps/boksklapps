import 'package:boksklapps/all_imports.dart';

/// Light Theme Provider from FlexColorScheme. Provides global theme to the app.
/// In the scheme parameter the color scheme is set by the themeColorProvider.
final StateProvider<ThemeData> themeLightProvider = StateProvider<ThemeData>(
  (ref) {
    return FlexThemeData.light(
      scheme: ref.watch(themeColorProvider),
      surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
      blendLevel: 10,
      bottomAppBarElevation: 6,
      subThemesData: const FlexSubThemesData(
        useM2StyleDividerInM3: true,
        thinBorderWidth: 2,
        thickBorderWidth: 2,
        unselectedToggleIsColored: true,
        sliderTrackHeight: 4,
        inputDecoratorRadius: 12,
        chipRadius: 12,
        popupMenuRadius: 12,
        popupMenuElevation: 6,
        tooltipRadius: 12,
        timePickerElementRadius: 12,
        drawerElevation: 6,
        bottomSheetElevation: 6,
        bottomSheetModalElevation: 6,
        bottomNavigationBarElevation: 6,
        navigationRailElevation: 6,
      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.bebasNeue().fontFamily,
    );
  },
);

/// Dark Theme Provider from FlexColorScheme
final StateProvider<ThemeData> themeDarkProvider =
    StateProvider<ThemeData>((ref) {
  return FlexThemeData.dark(
    scheme: ref.watch(themeColorProvider),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      useM2StyleDividerInM3: true,
      thinBorderWidth: 2,
      thickBorderWidth: 2,
      unselectedToggleIsColored: true,
      sliderTrackHeight: 4,
      inputDecoratorRadius: 12,
      chipRadius: 12,
      popupMenuRadius: 12,
      popupMenuElevation: 6,
      tooltipRadius: 12,
      timePickerElementRadius: 12,
      drawerElevation: 6,
      bottomSheetElevation: 6,
      bottomSheetModalElevation: 6,
      bottomNavigationBarElevation: 6,
      navigationRailElevation: 6,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.bebasNeue().fontFamily,
  );
});

/// ThemeColor Provider returns a FlexScheme.something to be used in the
/// Light and Dark Theme Providers
final StateNotifierProvider<ThemeColorState, FlexScheme> themeColorProvider =
    StateNotifierProvider<ThemeColorState, FlexScheme>((ref) {
  return ThemeColorState();
});

/// ThemeColorState class
class ThemeColorState extends StateNotifier<FlexScheme> {
  /// ThemeColorState constructor
  ThemeColorState() : super(FlexScheme.money);

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
    StateNotifierProvider<ThemeColorString, String>((ref) {
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

/// ThemeMode Provider provides Light, Dark or System theme. Standard to light.
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.light;
});

/// ThemeModeString Provider provides the String which is used in the
/// settings_screen to show the user which theme is currently active.
final StateNotifierProvider<ThemeModeString, String> themeModeStringProvider =
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
