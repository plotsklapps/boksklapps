import 'package:boksklapps/all_imports.dart';

void main() {
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
      title: 'BOKSKLAPPS - Sparring Partner',
      theme: ref.watch(lightThemeProvider),
      darkTheme: ref.watch(darkThemeProvider),
      themeMode: ref.watch(themeModeProvider),
      initialRoute: '/',
      routes: customRoutes,
    );
  }
}
