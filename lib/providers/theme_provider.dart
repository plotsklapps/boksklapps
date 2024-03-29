import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final NotifierProvider<ThemeNotifier, ThemeData> themeProvider =
    NotifierProvider<ThemeNotifier, ThemeData>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeData> {
  // We can use this in the UI as 'ref.watch(themeProvider.notifier).isDark' to
  // apply the correct theme on certain widgets.
  bool isDark = false;

  @override
  ThemeData build() {
    return lightTheme;
  }

  void toggle() {
    isDark = !isDark;
    state = isDark ? darkTheme : lightTheme;
  }
}

final ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.outerSpace,
  usedColors: 1,
  surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
  blendLevel: 1,
  appBarStyle: FlexAppBarStyle.background,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
    elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
    segmentedButtonSchemeColor: SchemeColor.primary,
    inputDecoratorSchemeColor: SchemeColor.primary,
    inputDecoratorBackgroundAlpha: 21,
    inputDecoratorRadius: 8,
    inputDecoratorUnfocusedHasBorder: false,
    inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
    fabUseShape: true,
    fabAlwaysCircular: true,
    popupMenuRadius: 6,
    popupMenuElevation: 4,
    alignedDropdown: true,
    dialogElevation: 3,
    dialogRadius: 20,
    useInputDecoratorThemeInDialogs: true,
    drawerIndicatorSchemeColor: SchemeColor.primary,
    bottomNavigationBarMutedUnselectedLabel: false,
    bottomNavigationBarMutedUnselectedIcon: false,
    menuRadius: 6,
    menuElevation: 4,
    menuBarRadius: 0,
    menuBarElevation: 1,
    navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.primary,
    navigationBarIndicatorOpacity: 1,
    navigationBarBackgroundSchemeColor: SchemeColor.background,
    navigationBarElevation: 0,
    navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.primary,
    navigationRailIndicatorOpacity: 1,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
    keepPrimary: true,
  ),
  tones: FlexTones.oneHue(Brightness.light),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: GoogleFonts.teko().fontFamily,
);

final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.outerSpace,
  usedColors: 1,
  surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
  blendLevel: 4,
  appBarStyle: FlexAppBarStyle.background,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendTextTheme: true,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
    elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
    segmentedButtonSchemeColor: SchemeColor.primary,
    inputDecoratorSchemeColor: SchemeColor.primary,
    inputDecoratorBackgroundAlpha: 43,
    inputDecoratorRadius: 8,
    inputDecoratorUnfocusedHasBorder: false,
    inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
    fabUseShape: true,
    fabAlwaysCircular: true,
    popupMenuRadius: 6,
    popupMenuElevation: 4,
    alignedDropdown: true,
    dialogElevation: 3,
    dialogRadius: 20,
    useInputDecoratorThemeInDialogs: true,
    drawerIndicatorSchemeColor: SchemeColor.primary,
    bottomNavigationBarMutedUnselectedLabel: false,
    bottomNavigationBarMutedUnselectedIcon: false,
    menuRadius: 6,
    menuElevation: 4,
    menuBarRadius: 0,
    menuBarElevation: 1,
    navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.primary,
    navigationBarIndicatorOpacity: 1,
    navigationBarBackgroundSchemeColor: SchemeColor.background,
    navigationBarElevation: 0,
    navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.primary,
    navigationRailIndicatorOpacity: 1,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  tones: FlexTones.oneHue(Brightness.dark),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: GoogleFonts.teko().fontFamily,
);
