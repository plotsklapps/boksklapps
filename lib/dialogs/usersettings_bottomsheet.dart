import 'package:boksklapps/dialogs/bmi_bottomsheet.dart';
import 'package:boksklapps/dialogs/signout_bottomsheet.dart';
import 'package:boksklapps/dialogs/username_bottomsheet.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetUserSettings extends StatelessWidget {
  const BottomSheetUserSettings({
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
            const Text('Settings', style: TextUtils.fontL),
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
              title: const Text('USERNAME'),
              subtitle: const Text('Change how we call you'),
              trailing: const FaIcon(FontAwesomeIcons.chevronRight),
            ),
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
              trailing: const FaIcon(FontAwesomeIcons.chevronRight),
            ),
            ListTile(
              onTap: () async {
                // Handle resetPassword logic.
              },
              leading: const FaIcon(
                FontAwesomeIcons.solidEnvelope,
              ),
              title: const Text('CHANGE EMAILADDRESS'),
              subtitle: const Text('Set up a new sign in method'),
              trailing: const FaIcon(FontAwesomeIcons.chevronRight),
            ),
            ListTile(
              onTap: () async {
                // Handle deleteUser logic.
              },
              leading: const FaIcon(
                FontAwesomeIcons.userXmark,
              ),
              title: const Text('DELETE PROFILE'),
              subtitle: const Text('Completely remove your data'),
              trailing: const FaIcon(FontAwesomeIcons.chevronRight),
            ),
            ListTile(
              onTap: () async {
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
              title: const Text('SIGN OUT'),
              subtitle: const Text('Go back to the login screen'),
              trailing: const FaIcon(FontAwesomeIcons.chevronRight),
            ),
          ],
        ),
      ),
    );
  }
}
