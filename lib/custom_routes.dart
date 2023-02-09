import 'package:boksklapps/all_imports.dart';

/// Variable customRoutes used in main.dart
Map<String, WidgetBuilder> customRoutes = {
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
  '/settings_screen': (context) {
    return const SettingsScreen();
  },
};
