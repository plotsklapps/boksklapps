import 'package:boksklapps/dialogs/firstsignin_bottomsheet.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:signals/signals_flutter.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

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
          // Watching a computed signal to provide the
          // corresponding Widget.
          child: cSpinnerStart.watch(context),
        ).animate(
          onPlay: (AnimationController controller) {
            controller.repeat(reverse: true);
          },
        ).rotate(delay: 1200.ms),
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
