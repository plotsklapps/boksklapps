import '../all_imports.dart';

/// LoginScreen class
class RegisterScreen extends StatelessWidget {
  /// LoginScreen constructor
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 800) {
      return const RegisterScreenMobile();
    } else if (MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width < 1200) {
      return const RegisterScreenTablet();
    } else {
      return const RegisterScreenDesktop();
    }
  }
}
