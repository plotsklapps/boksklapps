import 'package:boksklapps/all_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MainEntry(),
    ),
  );
}

/// MainEntry class
class MainEntry extends ConsumerWidget {
  /// MainEntry constructor
  const MainEntry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BOKSKLAPPS - Sparring Partner',
      theme: ref.watch(lightThemeProvider),
      darkTheme: ref.watch(darkThemeProvider),
      themeMode: ref.watch(themeModeProvider),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageTransition(
              child: const SplashScreen(),
              type: PageTransitionType.scale,
            );
          case '/home_screen':
            return PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.rightToLeft,
            );
          case '/login_screen':
            return PageTransition(
              child: const LoginScreen(),
              type: PageTransitionType.leftToRight,
            );
          case '/register_screen':
            return PageTransition(
              child: const RegisterScreen(),
              type: PageTransitionType.rightToLeft,
            );
          case '/password_screen':
            return PageTransition(
              child: const PasswordScreen(),
              type: PageTransitionType.rightToLeft,
            );
          default:
            return null;
        }
      },
    );
  }
}
