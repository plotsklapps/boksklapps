import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetSignout extends StatelessWidget {
  const BottomSheetSignout({
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
              await authService.signOut().then((_) {
                Navigation.navigateToSplashScreen(context);
              });
            },
            leading: const FaIcon(
              FontAwesomeIcons.personWalkingArrowRight,
            ),
            title: const Text('Sign Out'),
            subtitle: const Text('Go back to the welcome screen'),
            trailing: const FaIcon(FontAwesomeIcons.rightFromBracket),
          ),
        ],
      ),
    );
  }
}
