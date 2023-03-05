import 'package:boksklapps/all_imports.dart';

class SettingsScreenTablet extends ConsumerWidget {
  const SettingsScreenTablet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: StringUtils.kSettings,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    GetShitDoneWidget(),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
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
                        StringUtils.kPunchSound,
                      ),
                      subtitle: Text(
                        ref.watch(userSoundStringProvider),
                      ),
                      trailing: const SoundSwitch(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
