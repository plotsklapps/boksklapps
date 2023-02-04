import 'package:boksklapps/all_imports.dart';

/// FlexTheme for LightMode
/// Made for FlexColorScheme version 7.0.0-dev.2 (beta).
ThemeData themeLight = FlexThemeData.light(
  scheme: FlexScheme.outerSpace,
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

/// FlexTheme for DarkMode
ThemeData themeDark = FlexThemeData.dark(
  scheme: FlexScheme.outerSpace,
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
