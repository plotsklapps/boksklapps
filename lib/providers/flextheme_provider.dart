import 'package:boksklapps/all_imports.dart';

// Light Theme Provider from FlexColorScheme. Provides global theme to the app.
// In the scheme parameter the color scheme is set by the themeColorProvider.
final StateProvider<ThemeData> themeLightProvider = StateProvider<ThemeData>(
  (StateProviderRef<ThemeData> ref) {
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
      // Sets entire app to use Bebas Neue font.
      fontFamily: GoogleFonts.bebasNeue().fontFamily,
    );
  },
);

// Dark Theme Provider from FlexColorScheme. Provides global theme to the app.
// In the scheme parameter the color scheme is set by the themeColorProvider.
final StateProvider<ThemeData> themeDarkProvider = StateProvider<ThemeData>(
  (StateProviderRef<ThemeData> ref) {
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
      // Sets entire app to use Bebas Neue font.
      fontFamily: GoogleFonts.bebasNeue().fontFamily,
    );
  },
);
