import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/dialogs/firstsignin_bottomsheet.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() {
    return StartScreenState();
  }
}

class StartScreenState extends ConsumerState<StartScreen> {
  final AuthService _authService = AuthService();
  late final User? _user;

  @override
  void initState() {
    super.initState();
    _checkAuthentication(ref);
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _checkAuthentication(WidgetRef ref) async {
    // Talking to Firebase to check if the user is logged in and
    // using (computed) signals to update the UI accordingly.
    sCurrentUser.value = FirebaseAuth.instance.currentUser;

    // Delay this function to avoid initState issues.
    await Future<void>.delayed(const Duration(milliseconds: 800), () async {
      // Check if the user is logged in and if the email is verified.
      if (cLoggedIn.value) {
        if (cEmailVerified.value) {
          // Get the user document from Firestore and store the values
          // in their respective signals.
          await _authService.getUserDoc(
            user: sCurrentUser.value!,
            onError: (String error) {
              _handleErrors(error, ref);
            },
            onSuccess: _handleSuccess,
          );
        } else {
          Navigate.toStartScreen(context);
        }
      } else {
        Navigate.toStartScreen(context);
      }
    });
  }

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
            await showModalBottomSheet<void>(
              showDragHandle: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return const BottomSheetFirstSignin();
              },
            );
          },
          child: const FaIcon(FontAwesomeIcons.forwardStep),
        ).animate(
          onPlay: (AnimationController controller) {
            controller.repeat(reverse: true);
          },
        ).rotate(delay: 1200.ms),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: const BottomBarTitle(
          hasLeading: false,
          title: 'BOKSklapps',
        ),
      ),
    );
  }
}
