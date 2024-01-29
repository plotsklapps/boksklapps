import 'package:boksklapps/dialogs/signup_bottomsheet.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class BottomSheetFirstSignin extends ConsumerWidget {
  const BottomSheetFirstSignin({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () async {
              Navigator.pop(context);
              var emailAuth = 'someemail@domain.com';
              await _firebaseAuth
                  .sendSignInLinkToEmail(
                      email: emailAuth, actionCodeSettings: acs)
                  .catchError((onError) =>
                      print('Error sending email verification $onError'))
                  .then(
                      (value) => print('Successfully sent email verification'));
              // await showModalBottomSheet<void>(
              //     showDragHandle: true,
              //     isScrollControlled: true,
              //     context: context,
              //     builder: (BuildContext context) {
              //       return const BottomSheetSignup();
              //     });
            },
            leading: const FaIcon(
              FontAwesomeIcons.userPlus,
            ),
            title: const Text('Create an account'),
            subtitle: const Text(
              'Get a personalized experience and save your statistics (recommended).',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            onTap: () async {
              // Handle createUser logic.
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
              // Set isSneakPeeker bool true. Give user complete access,
              // except for Firebase.
              ref.read(isSneakPeekerProvider.notifier).setTrue();
              Navigator.pop(context);
              Navigation.navigateToHomeScreen(context);
              rootScaffoldMessengerKey.currentState!.showSnackBar(
                const SnackBar(
                  content: Text(
                    'Welcome to BOKSklapps! You are a sneak peeker, your data will NOT be stored.',
                  ),
                  showCloseIcon: true,
                ),
              );
              Logger().i('User has signed in as Sneak Peeker.');
            },
            leading: const FaIcon(
              FontAwesomeIcons.userSecret,
            ),
            title: const Text('Sneak peek'),
            subtitle: const Text(
              'Try out BOKSklapps without storing any data.',
            ),
            trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
        ],
      ),
    );
  }
}
