import 'package:boksklapps/all_imports.dart';

/// LoginScreen class
class LoginScreen extends StatelessWidget {
  /// LoginScreen constructor
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 800) {
      return const LoginScreenMobile();
    } else if (MediaQuery.of(context).size.width < 1200) {
      return const LoginScreenTablet();
    } else {
      return const LoginScreenDesktop();
    }
  }
}
