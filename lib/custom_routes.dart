import 'package:boksklapps/all_imports.dart';

/// Variable customRoutes used in main.dart
Map<String, WidgetBuilder> customRoutes = <String, WidgetBuilder>{
  '/': (BuildContext context) {
    return const SplashScreen();
  },
  '/login_screen': (BuildContext context) {
    return const LoginScreen();
  },
  '/register_screen': (BuildContext context) {
    return const RegisterScreen();
  },
  '/password_screen': (BuildContext context) {
    return const PasswordScreen();
  },
  '/home_screen': (BuildContext context) {
    return const HomeScreen();
  },
  '/account_screen': (BuildContext context) {
    return const AccountScreen();
  },
  '/settings_screen': (BuildContext context) {
    return const SettingsScreen();
  },
  '/about_screen': (BuildContext context) {
    return const AboutScreen();
  },
  '/timer_screen': (BuildContext context) {
    return const TimerScreen();
  },
  '/punches_screen': (BuildContext context) {
    return const PunchesScreen();
  },
  '/tempo_screen': (BuildContext context) {
    return const TempoScreen();
  },
  '/workout_screen': (BuildContext context) {
    return const WorkoutScreen();
  },
};
