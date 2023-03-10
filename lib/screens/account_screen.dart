import 'package:boksklapps/all_imports.dart';

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
      // TODO: Create tablet version
      return const AccountScreenTablet();
    } else {
      // TODO: Create desktop version
      return const AccountScreenDesktop();
    }
  }
}
