import 'package:boksklapps/all_imports.dart';

/// SettingsScreen class
class SettingsScreen extends ConsumerWidget {
  /// SettingsScreen constructor
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringUtils.kSettings,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text(
              StringUtils.kLightSystemDark,
            ),
            subtitle: Text(
              ref.watch(themeModeStringProvider),
            ),
            trailing: const ThemeModeSwitch(),
          ),
          ListTile(
            title: const Text(
              'Color Scheme',
            ),
            subtitle: Text(
              ref.watch(themeColorStringProvider),
            ),
            trailing: const ThemeColorSwitch(),
          ),
        ],
      ),
    );
  }
}
