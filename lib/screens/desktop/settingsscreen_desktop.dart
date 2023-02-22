import 'package:boksklapps/all_imports.dart';

class SettingsScreenDesktop extends ConsumerWidget {
  const SettingsScreenDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringUtils.kSettings,
        ),
        centerTitle: true,
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
