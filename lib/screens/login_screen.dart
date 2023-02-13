import 'package:boksklapps/all_imports.dart';

/// LoginScreen class
class LoginScreen extends StatelessWidget {
  /// LoginScreen constructor
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    if (screenwidth < 800) {
      return const LoginScreenMobile();
    } else if (screenwidth >= 800 && screenwidth < 1200) {
      return const LoginScreenTablet();
    } else {
      return const LoginScreenDesktop();
    }
  }
}
