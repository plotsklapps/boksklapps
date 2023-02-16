import '../all_imports.dart';

/// AccountScreen class
class AccountScreen extends StatelessWidget {
  /// AccountScreen constructor
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;

    if (screenwidth < 700) {
      return const AccountScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      return const AccountScreenMobile();
    } else {
      return const AccountScreenMobile();
    }
  }
}
