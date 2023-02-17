import 'package:boksklapps/all_imports.dart';

/// PasswordScreen class
class PasswordScreen extends StatelessWidget {
  /// PasswordScreen constructor
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    if (screenwidth < 700) {
      return const PasswordScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      return const PasswordScreenTablet();
    } else {
      return const PasswordScreenDesktop();
    }
  }
}
