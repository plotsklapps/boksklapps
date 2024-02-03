import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/providers/displayname_signal.dart';
import 'package:boksklapps/screens/splash_screen.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetSignout extends ConsumerStatefulWidget {
  const BottomSheetSignout({super.key});

  @override
  ConsumerState<BottomSheetSignout> createState() {
    return BottomSheetSignoutState();
  }
}

class BottomSheetSignoutState extends ConsumerState<BottomSheetSignout> {
  final AuthService _firebaseAuth = AuthService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          0,
          8,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Are you sure you want to sign out?',
              style: TextUtils.fontL,
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
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
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    ref.invalidate(displayNameProvider);
                    // Log in to Firebase with the email and password.
                    await _firebaseAuth.signOut().then((_) async {
                      // Reload the user to make sure the backend is
                      // refreshed.
                      await _firebaseAuth.reload();
                    }).then((_) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return const SplashScreen();
                          },
                        ),
                      );
                    });
                    rootScaffoldMessengerKey.currentState!.showSnackBar(
                      const SnackBar(
                        content: Text(
                          'You have successfully signed out.',
                        ),
                        showCloseIcon: true,
                      ),
                    );
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(strokeWidth: 6)
                      : const FaIcon(FontAwesomeIcons.rightFromBracket),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
