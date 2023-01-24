import 'package:boksklapps/all_imports.dart';

/// Routes Map
Map<String, WidgetBuilder> customRoutes = {
  '/': (context) {
    return const SplashScreen();
  },
  '/home_screen': (context) {
    return const HomeScreen();
  },
  '/login_screen': (context) {
    return const LoginScreen();
  },
  '/register_screen': (context) {
    return const RegisterScreen();
  },
  '/password_screen': (context) {
    return const PasswordScreen();
  },
};
