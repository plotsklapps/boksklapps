import 'package:boksklapps/main.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetHomeScreen extends ConsumerWidget {
  const BottomSheetHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.96,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.userSecret),
            title: Text('Account'),
            subtitle: Text('Manage your profile settings'),
            trailing: FaIcon(FontAwesomeIcons.forwardStep),
          ),
          ListTile(
            onTap: () {
              ref.read(isDarkTheme.notifier).toggle();
              Navigator.pop(context);
              rootScaffoldMessengerKey.currentState!.showSnackBar(
                SnackBar(
                  content: Text(
                    ref.watch(isDarkTheme)
                        ? 'Dark theme enabled'
                        : 'Light theme enabled',
                  ),
                  duration: const Duration(seconds: 1),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {
                      rootScaffoldMessengerKey.currentState!
                          .hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            },
            leading: ref.watch(isDarkTheme)
                ? const FaIcon(FontAwesomeIcons.solidMoon)
                : const FaIcon(FontAwesomeIcons.solidSun),
            title: const Text('Theme'),
            subtitle: Text(
              ref.watch(isDarkTheme)
                  ? 'Dark theme enabled'
                  : 'Light theme enabled',
            ),
            trailing: const FaIcon(FontAwesomeIcons.forwardStep),
          ),
        ],
      ),
    );
  }
}
