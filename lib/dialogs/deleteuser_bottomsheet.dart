import 'package:boksklapps/dialogs/deleteuserconfirmation_bottomsheet.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetDeleteUser extends ConsumerWidget {
  const BottomSheetDeleteUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Delete your account'),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            const Text(
              'Are you sure you want to delete your account? This action is '
              'irreversible and will delete all your data.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Pop the bottomsheet.
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    // Pop the bottomsheet.
                    Navigator.pop(context);

                    // Show a new bottomsheet.
                    showModalBottomSheet<Widget>(
                      showDragHandle: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const BottomSheetDeleteUserConfirmation();
                      },
                    );
                  },
                  backgroundColor: ref.watch(themeProvider.notifier).isDark
                      ? flexSchemeDark.error
                      : flexSchemeLight.error,
                  child: FaIcon(
                    FontAwesomeIcons.solidTrashCan,
                    color: ref.watch(themeProvider.notifier).isDark
                        ? flexSchemeDark.onError
                        : flexSchemeLight.onError,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
