import 'package:boksklapps/dialogs/firstsignin_bottomsheet.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
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
            sShowSpinner.value = true;
            await showModalBottomSheet<void>(
              showDragHandle: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return const BottomSheetFirstSignin();
              },
            );
            sShowSpinner.value = false;
          },
          child: cShowSpinner.watch(context),
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
