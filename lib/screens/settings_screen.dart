import '../all_imports.dart';

/// SettingsScreen class
class SettingsScreen extends StatelessWidget {
  /// SettingsScreen constructor
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1000) {
      return const SettingsScreenMobile();
    } else {
      return const SettingsScreenMobile();
    }
  }
}
