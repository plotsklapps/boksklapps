import 'package:boksklapps/dialogs/firstsignin_bottomsheet.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() {
    return StartScreenState();
  }
}

class StartScreenState extends State<StartScreen> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/GIF/littleBoxer.gif',
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            setState(() {
              _isSigningIn = true;
            });
            await showModalBottomSheet<void>(
              showDragHandle: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return const BottomSheetFirstSignin();
              },
            );
            setState(() {
              _isSigningIn = false;
            });
          },
          child: _isSigningIn
              ? const CircularProgressIndicator(strokeWidth: 6)
              : const FaIcon(FontAwesomeIcons.forwardStep),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: const BottomAppBar(
          height: 64,
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Text(
            'BOKSklapps',
            style: TextUtils.fontXL,
          ),
        ),
      ),
    );
  }
}
