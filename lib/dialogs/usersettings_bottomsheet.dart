import 'package:boksklapps/dialogs/bmi_bottomsheet.dart';
import 'package:boksklapps/dialogs/deleteuser_bottomsheet.dart';
import 'package:boksklapps/dialogs/email_bottomsheet.dart';
import 'package:boksklapps/dialogs/signout_bottomsheet.dart';
import 'package:boksklapps/dialogs/username_bottomsheet.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetUserSettings extends StatelessWidget {
  const BottomSheetUserSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'User Settings'),
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
                    return const BottomSheetUsername();
                  },
                );
              },
              leading: const FaIcon(
                FontAwesomeIcons.signature,
              ),
              title: const Text('Username'),
              subtitle: const Text('Change how we call you'),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade().moveX(delay: 200.ms, begin: -32),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetBMI();
                  },
                );
              },
              leading: const FaIcon(
                FontAwesomeIcons.weightScale,
              ),
              title: const Text('BMI'),
              subtitle: const Text('Calculate your Body Mass Index'),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade(delay: 200.ms).moveX(delay: 400.ms, begin: -32),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetEmail();
                  },
                );
              },
              leading: const FaIcon(
                FontAwesomeIcons.solidEnvelope,
              ),
              title: const Text('Change email address'),
              subtitle: const Text('Set up a new sign in method'),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade(delay: 400.ms).moveX(delay: 600.ms, begin: -32),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetDeleteUser();
                  },
                );
              },
              leading: const FaIcon(
                FontAwesomeIcons.userXmark,
              ),
              title: const Text('Delete profile'),
              subtitle: const Text('Completely remove your data'),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade(delay: 600.ms).moveX(delay: 800.ms, begin: -32),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await showModalBottomSheet<Widget>(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetSignout();
                  },
                );
              },
              leading: const FaIcon(
                FontAwesomeIcons.personWalkingArrowRight,
              ),
              title: const Text('Sign out'),
              subtitle: const Text('Go back to the login screen'),
              trailing: const FaIcon(FontAwesomeIcons.forwardStep),
            ).animate().fade(delay: 800.ms).moveX(delay: 1000.ms, begin: -32),
          ],
        ),
      ),
    );
  }
}
