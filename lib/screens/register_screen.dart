import 'package:boksklapps/all_imports.dart';

/// LoginScreen class
class RegisterScreen extends StatelessWidget {
  /// LoginScreen constructor
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1000) {
      return const RegisterScreenMobile();
    } else {
      return const RegisterScreenDesktop();
    }
  }
}
