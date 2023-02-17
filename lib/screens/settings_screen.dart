import 'package:boksklapps/all_imports.dart';

/// SettingsScreen class
class SettingsScreen extends StatelessWidget {
  /// SettingsScreen constructor
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;

    if (screenwidth < 700) {
      return const SettingsScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      return const SettingsScreenMobile();
    } else {
      return const SettingsScreenMobile();
    }
  }
}
