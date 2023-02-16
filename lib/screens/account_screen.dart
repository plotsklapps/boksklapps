import '../all_imports.dart';

/// AccountScreen class
class AccountScreen extends StatelessWidget {
  /// AccountScreen constructor
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1000) {
      return const AccountScreenMobile();
    } else {
      return const AccountScreenMobile();
    }
  }
}
