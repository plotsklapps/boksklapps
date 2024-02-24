import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBarTitle extends StatelessWidget {
  const BottomBarTitle({
    required this.title,
    required this.hasLeading,
    super.key,
  });

  final String title;
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 56,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        children: <Widget>[
          if (hasLeading) const BackButton(),
          Text(
            title,
            style: TextUtils.fontXL,
          ),
        ],
      ),
    );
  }
}

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({
    required this.bottomSheet,
    required this.icon,
    required this.hasLeading,
    super.key,
  });

  final Widget bottomSheet;
  final IconData icon;
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 56,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        children: <Widget>[
          if (hasLeading) const BackButton(),
          IconButton(
            icon: FaIcon(icon),
            onPressed: () {
              showModalBottomSheet<Widget>(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return bottomSheet;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
