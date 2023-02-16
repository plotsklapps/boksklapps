import '../all_imports.dart';

/// PasswordScreen class
class PasswordScreen extends StatelessWidget {
  /// PasswordScreen constructor
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 800) {
      return const PasswordScreenMobile();
    } else if (MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width < 1200) {
      return const PasswordScreenTablet();
    } else {
      return const PasswordScreenDesktop();
    }
  }
}
