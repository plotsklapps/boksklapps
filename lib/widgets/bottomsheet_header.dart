import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Returns a ListTile with a title and a close button to get a consistent
// look for the bottomsheets.
class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextUtils.fontL,
      ),
      trailing: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const FaIcon(
          FontAwesomeIcons.xmark,
        ),
      ),
    );
  }
}
