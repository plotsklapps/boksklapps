import 'package:boksklapps/dialogs/usersettings_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/flextheme.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetMainMenu extends StatelessWidget {
  const BottomSheetMainMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Local signal to compute which icon to show.
    final Computed<Widget> cSneakPeeker = computed(() {
      return sSneakPeeker.value
          ? const FaIcon(FontAwesomeIcons.userSecret)
          : const FaIcon(FontAwesomeIcons.userPen);
    });
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Settings'),
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
              leading: cSneakPeeker.watch(context),
              title: const Text('Account'),
              subtitle: const Text('Manage your profile settings'),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade().moveX(delay: 200.ms, begin: -32),
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
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms, begin: -32),
          ],
        ),
      ),
    );
  }
}
