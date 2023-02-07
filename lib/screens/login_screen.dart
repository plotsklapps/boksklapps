import 'package:boksklapps/all_imports.dart';

/// LoginScreen class
class LoginScreen extends StatelessWidget {
  /// LoginScreen constructor
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1000) {
      return const LoginScreenMobile();
    } else {
      return const LoginScreenDesktop();
    }
  }
}
