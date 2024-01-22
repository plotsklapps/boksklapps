import 'package:boksklapps/dialogs/homescreen_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 64,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bars),
            onPressed: () {
              showModalBottomSheet<Widget>(
                showDragHandle: true,
                context: context,
                builder: (BuildContext context) {
                  return const BottomSheetHomeScreen();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
