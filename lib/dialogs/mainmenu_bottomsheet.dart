import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/dialogs/usersettings_bottomsheet.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetMainMenu extends ConsumerStatefulWidget {
  const BottomSheetMainMenu({
    super.key,
  });

  @override
  ConsumerState<BottomSheetMainMenu> createState() {
    return BottomSheetMainMenuState();
  }
}

class BottomSheetMainMenuState extends ConsumerState<BottomSheetMainMenu> {
  @override
  Widget build(BuildContext context) {
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
                // Pop the bottomsheet.
                Navigator.pop(context);

                // Show the user settings bottomsheet.
                await showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetUserSettings();
                  },
                );
              },
              leading: ref.watch(sneakPeekProvider)
                  ? const FaIcon(FontAwesomeIcons.userSecret)
                  : const FaIcon(FontAwesomeIcons.userGear),
              title: const Text('Account'),
              subtitle: const Text('Manage your profile settings'),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade().moveX(delay: 200.ms, begin: -32),
            ListTile(
              onTap: () {
                // Toggle the theme.
                ref.read(themeProvider.notifier).toggle();

                // Pop the bottomsheet.
                Navigator.pop(context);

                // Show a SnackBar to the user.
                CustomSnackBars.showSuccessSnackBar(
                  ref,
                  ref.watch(themeProvider.notifier).isDark
                      ? 'Dark theme activated'
                      : 'Light theme activated',
                );
              },
              leading: ref.watch(themeProvider.notifier).isDark
                  ? const FaIcon(FontAwesomeIcons.solidMoon)
                  : const FaIcon(FontAwesomeIcons.solidSun),
              title: const Text('Theme'),
              subtitle: Text(
                ref.watch(themeProvider.notifier).isDark
                    ? 'Dark theme active'
                    : 'Light theme active',
              ),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms, begin: -32),
          ],
        ),
      ),
    );
  }
}
