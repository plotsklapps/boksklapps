import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/dialogs/signin_bottomsheet.dart';
import 'package:boksklapps/dialogs/signup_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetFirstSignin extends ConsumerStatefulWidget {
  const BottomSheetFirstSignin({
    super.key,
  });

  @override
  ConsumerState<BottomSheetFirstSignin> createState() {
    return BottomSheetFirstSigninState();
  }
}

class BottomSheetFirstSigninState
    extends ConsumerState<BottomSheetFirstSignin> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Choose a sign in method', style: TextUtils.fontL),
          const Divider(thickness: 2),
          const SizedBox(height: 16),
          ListTile(
            onTap: () async {
              // Close this bottomsheet and open the signup bottomsheet.
              Navigator.pop(context);
              await showModalBottomSheet<void>(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const BottomSheetSignup();
                },
              );
            },
            leading: const FaIcon(
              FontAwesomeIcons.userPlus,
            ),
            title: const Text('Create an account'),
            subtitle: const Text(
              'Get a personalized experience and save your statistics '
              '(recommended).',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () async {
              // Close this bottomsheet and open the signin bottomsheet.
              Navigator.pop(context);
              await showModalBottomSheet<void>(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const BottomSheetSignin();
                },
              );
            },
            leading: const FaIcon(
              FontAwesomeIcons.userCheck,
            ),
            title: const Text('Use an existing account'),
            subtitle: const Text(
              'You already used BOKSklapps before and want to sign in again.',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () async {
              setState(() {
                _isLoading = true;
              });
              // Set isSneakPeeker bool true. Give user complete access,
              // and sign in anonymously so the user may turn it into an
              // actual account later.
              ref.read(isSneakPeekerProvider.notifier).setTrue();
              await _authService.signInAnonymously().then((_) {
                _authService.reload();
                Logger().i('User has signed in as Sneak Peeker.');
                Navigation.navigateToHomeScreen(context);
                setState(() {
                  _isLoading = false;
                });
                rootScaffoldMessengerKey.currentState!.showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Welcome to BOKSklapps! You are a sneak peeker, '
                      'your data will NOT be stored.',
                    ),
                    showCloseIcon: true,
                  ),
                );
              });
            },
            leading: _isLoading
                ? const CircularProgressIndicator(strokeWidth: 6)
                : const FaIcon(
                    FontAwesomeIcons.userSecret,
                  ),
            title: const Text('Sneak peek'),
            subtitle: const Text(
              'Try out BOKSklapps anonymously without storing any data.',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
        ],
      ),
    );
  }
}
