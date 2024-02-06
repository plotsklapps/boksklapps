import 'package:boksklapps/firebase_options.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

// Using a GlobalKey for showing SnackBars to users. Mostly because
// it's convenient, but also to avoid the 'Do not use BuildContexts
// across async gaps' whining from the linter and to not have
// if (!mounted) return; code scattered across the app.
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized() tells Flutter not to start
  // running the application widget code until the Flutter framework is
  // completely booted.
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp sets up a connection between the app and the
  // Firebase project. The DefaultFirebaseOptions.currentPlatform
  // is imported from firebase_options.dart. This static value detects
  // which platform the user is running, and passes in the corresponding
  // Firebase keys.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp starts the actual Flutter app.
  runApp(const MainEntry());
}

class MainEntry extends StatelessWidget {
  const MainEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      // Watching a computed signal to provide the requested ThemeData.
      theme: cThemeMode.watch(context),
      initialRoute: NavString.splashScreen,
      routes: routes,
    );
  }
}
