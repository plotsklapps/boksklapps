import 'package:boksklapps/dialogs/deleteuserconfirmation_bottomsheet.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetDeleteUser extends ConsumerWidget {
  const BottomSheetDeleteUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeProvider.notifier).isDark;
    // Computed signal to show a CircularProgressIndicator or a trash
    // can icon.
    final Computed<Widget> cShowSpinner = computed(() {
      return sShowSpinner.value
          ? CircularProgressIndicator(
              strokeWidth: 6,
              color: isDark ? flexSchemeDark.onError : flexSchemeLight.onError,
            )
          : FaIcon(
              FontAwesomeIcons.solidTrashCan,
              color: isDark ? flexSchemeDark.onError : flexSchemeLight.onError,
            );
    });
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
                    sShowSpinner.value = false;
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    // Pop the bottomsheet and show the reauthentication
                    // bottomsheet.
                    Navigator.pop(context);
                    showModalBottomSheet<Widget>(
                      showDragHandle: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const BottomSheetDeleteUserConfirmation();
                      },
                    );
                  },
                  backgroundColor: sDarkTheme.value
                      ? flexSchemeDark.error
                      : flexSchemeLight.error,
                  child: cShowSpinner.watch(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
