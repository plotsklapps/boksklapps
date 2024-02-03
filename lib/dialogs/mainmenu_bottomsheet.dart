import 'package:boksklapps/dialogs/usersettings_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetMainMenu extends StatelessWidget {
  const BottomSheetMainMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () async {
              await showModalBottomSheet<Widget>(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const BottomSheetUserSettings();
                },
              );
            },
            leading: const FaIcon(FontAwesomeIcons.userSecret),
            title: const Text('Account'),
            subtitle: const Text('Manage your profile settings'),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () {
              isDarkThemeSignal.value = !isDarkThemeSignal.value;
              Navigator.pop(context);
              rootScaffoldMessengerKey.currentState!.showSnackBar(
                SnackBar(
                  content: Text(
                    isDarkThemeSignal.value
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
            leading: isDarkThemeSignal.value
                ? const FaIcon(FontAwesomeIcons.solidMoon)
                : const FaIcon(FontAwesomeIcons.solidSun),
            title: const Text('Theme'),
            subtitle: Text(
              isDarkThemeSignal.value
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
