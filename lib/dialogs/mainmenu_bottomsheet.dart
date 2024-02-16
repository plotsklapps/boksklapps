import 'package:boksklapps/dialogs/usersettings_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetMainMenu extends StatelessWidget {
  const BottomSheetMainMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Settings', style: TextUtils.fontL),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                ),
              ],
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
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
                  : const FaIcon(FontAwesomeIcons.userPen),
              title: const Text('Account'),
              subtitle: const Text('Manage your profile settings'),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ),
            ListTile(
              onTap: () {
                sDarkTheme.value = !sDarkTheme.value;
                Navigator.pop(context);
                rootScaffoldMessengerKey.currentState!.showSnackBar(
                  SnackBar(
                    content: Text(
                      sDarkTheme.value
                          ? 'Dark theme activated'
                          : 'Light theme activated',
                    ),
                    showCloseIcon: true,
                  ),
                );
              },
              leading: sDarkTheme.value
                  ? const FaIcon(FontAwesomeIcons.solidMoon)
                  : const FaIcon(FontAwesomeIcons.solidSun),
              title: const Text('Theme'),
              subtitle: Text(
                sDarkTheme.value ? 'Dark theme active' : 'Light theme active',
              ),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ),
          ],
        ),
      ),
    );
  }
}
