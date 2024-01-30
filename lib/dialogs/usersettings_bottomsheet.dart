import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/dialogs/signout_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetUserSettings extends StatelessWidget {
  const BottomSheetUserSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () async {
              // Handle createUser logic.
            },
            leading: const FaIcon(
              FontAwesomeIcons.userPlus,
            ),
            title: const Text('NEW USER'),
            subtitle: const Text('CREATE A FRESH ACCOUNT'),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () async {
              // Handle loginUser logic.
            },
            leading: const FaIcon(
              FontAwesomeIcons.userCheck,
            ),
            title: const Text('EXISTING USER'),
            subtitle: const Text('LOG IN FROM AN EXISTING ACCOUNT'),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () async {
              // Handle resetPassword logic.
            },
            leading: const FaIcon(
              FontAwesomeIcons.lock,
            ),
            title: const Text('RESET PASSWORD'),
            subtitle: const Text('CHANGE YOUR LOG IN CREDENTIALS'),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () async {
              // Handle deleteUser logic.
            },
            leading: const FaIcon(
              FontAwesomeIcons.userXmark,
            ),
            title: const Text('DELETE USER'),
            subtitle: const Text('COMPLETELY REMOVE YOUR DATA'),
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
            subtitle: const Text('GO BACK TO WELCOME SCREEN'),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
        ],
      ),
    );
  }
}
