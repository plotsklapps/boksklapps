import 'package:boksklapps/dialogs/usersettings_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
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
              Navigator.pop(context);
              await showModalBottomSheet<Widget>(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const BottomSheetUserSettings();
                },
              );
            },
            leading: sSneakPeeker.value
                ? const FaIcon(FontAwesomeIcons.userSecret)
                : const FaIcon(FontAwesomeIcons.userCheck),
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
                        ? 'Dark theme activated'
                        : 'Light theme activated',
                  ),
                  showCloseIcon: true,
                ),
              );
            },
            leading: isDarkThemeSignal.value
                ? const FaIcon(FontAwesomeIcons.solidMoon)
                : const FaIcon(FontAwesomeIcons.solidSun),
            title: const Text('Theme'),
            subtitle: Text(
              isDarkThemeSignal.value
                  ? 'Dark theme active'
                  : 'Light theme active',
            ),
            trailing: const FaIcon(FontAwesomeIcons.forwardStep),
          ),
        ],
      ),
    );
  }
}
