import 'package:boksklapps/all_imports.dart';

class SettingsScreenMobile extends ConsumerWidget {
  const SettingsScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: StringUtils.kSettings,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
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
                  'Punch Sound',
                ),
                subtitle: Text(
                  ref.watch(userSoundStringProvider),
                ),
                trailing: const VoiceSwitch(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
