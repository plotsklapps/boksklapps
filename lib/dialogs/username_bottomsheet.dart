import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

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
