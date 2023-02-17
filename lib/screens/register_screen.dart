import 'package:boksklapps/all_imports.dart';

/// LoginScreen class
class RegisterScreen extends StatelessWidget {
  /// LoginScreen constructor
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;

    if (screenwidth < 700) {
      return const RegisterScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      return const RegisterScreenTablet();
    } else {
      return const RegisterScreenDesktop();
    }
  }
}
