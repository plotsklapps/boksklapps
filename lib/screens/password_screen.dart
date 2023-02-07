import 'package:boksklapps/all_imports.dart';

/// PasswordScreen class
class PasswordScreen extends StatelessWidget {
  /// PasswordScreen constructor
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1000) {
      return const PasswordScreenMobile();
    } else {
      return const PasswordScreenDesktop();
    }
  }
}
