import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/dialogs/signout_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

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
                // Handle loginUser logic.
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

class BottomSheetUsername extends StatefulWidget {
  const BottomSheetUsername({
    super.key,
  });

  @override
  State<BottomSheetUsername> createState() {
    return BottomSheetUsernameState();
  }
}

class BottomSheetUsernameState extends State<BottomSheetUsername> {
  late TextEditingController _usernameController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
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
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(label: Text('New username')),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    final String newDisplayName =
                        _usernameController.text.trim();
                    await authService.setDisplayName(
                      newDisplayName: newDisplayName,
                      onError: _handleErrors,
                      onSuccess: _handleSuccess,
                    );
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(strokeWidth: 6)
                      : const FaIcon(FontAwesomeIcons.forwardStep),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleErrors(String error) {
    Logger().e('Error: $error');
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  void _handleSuccess() {
    Logger().i('User has changed their displayName.');
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text(
          'You have successfully changed your username.',
        ),
        showCloseIcon: true,
      ),
    );
  }
}
