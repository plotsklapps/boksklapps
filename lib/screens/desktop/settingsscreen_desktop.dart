import 'package:boksklapps/all_imports.dart';

class SettingsScreenDesktop extends ConsumerWidget {
  const SettingsScreenDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: StringUtils.kSettings,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          // Wrap the Row() in a SizedBox() to set the total height
          // at 85% of the screen height so that the SingleChildScrollView()
          // won't affect any of the widgets inside the Row()
          // and the keyboard can easily pop up without any issues
          height: MediaQuery.of(context).size.height * 0.85,
          child: Row(
            children: <Widget>[
              const DrawerWidget(),
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
