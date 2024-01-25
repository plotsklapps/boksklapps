import 'package:boksklapps/firebase_options.dart';
import 'package:boksklapps/screens/splash_screen.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The root ScaffoldMessenger can also be accessed by providing a key to
// MaterialApp.scaffoldMessengerKey. This way, the ScaffoldMessengerState
// can be directly accessed without first obtaining it from a BuildContext
// via ScaffoldMessenger.of. From the key, use the GlobalKey.currentState
// getter.
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized() tells Flutter not to start
  // running the application widget code until the Flutter framework is
  // completely booted.
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp sets up a connection between your Flutter app
  // and your Firebase project. The DefaultFirebaseOptions.currentPlatform
  // is imported from our generated firebase_options.dart file. This static
  // value detects which platform you're running on, and passes in the
  // corresponding Firebase keys.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp starts the Flutter app (ProviderScope is a Riverpod must have).
  runApp(const ProviderScope(child: MainEntry()));
}

class MainEntry extends ConsumerWidget {
  const MainEntry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme:
          ref.watch(isDarkTheme) ? ref.watch(darkTheme) : ref.watch(lightTheme),
      home: const SplashScreen(),
    );
  }
}
