import 'package:boksklapps/all_imports.dart';

/// Routes Map
Map<String, WidgetBuilder> customRoutes = {
  '/': (context) {
    return const SplashScreen();
  },
  '/home_screen': (context) {
    return const HomeScreen();
  },
};
