import 'package:boksklapps/all_imports.dart';

// SettingsScreenMobile class
class SettingsScreenMobile extends ConsumerWidget {
  // SettingsScreenMobile constructor
  const SettingsScreenMobile({super.key});

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
        children: <ListTile>[
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
              StringUtils.kColorScheme,
            ),
            subtitle: Text(
              ref.watch(themeColorStringProvider),
            ),
            trailing: const ThemeColorSwitch(),
          ),
          ListTile(
            title: const Text(
              'Timers',
            ),
            subtitle: const Text(
              'Adjust boxing timers',
            ),
            trailing: const Icon(
              Icons.edit_outlined,
            ),
            onTap: () async {},
          ),
        ],
      ),
    );
  }
}
