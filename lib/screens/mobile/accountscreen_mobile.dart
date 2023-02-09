import 'package:boksklapps/all_imports.dart';

/// AccountScreenMobile class
class AccountScreenMobile extends ConsumerWidget {
  /// AccountScreenMobile constructor
  const AccountScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringUtils.kAccount,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text(
              ref.watch(currentEmailProvider)!,
            ),
            subtitle: const Text(
              'Emailaddress',
            ),
            trailing: const Icon(Icons.edit_note_outlined),
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
    );
  }
}
