import 'package:boksklapps/all_imports.dart';

Future<void> main() async {
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
      theme: ref.watch(themeLightProvider),
      darkTheme: ref.watch(themeDarkProvider),
      themeMode: ref.watch(themeModeProvider),
      initialRoute: '/',
      routes: customRoutes,
    );
  }
}
