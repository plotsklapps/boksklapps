import 'package:boksklapps/all_imports.dart';

/// HomeScreen class
class HomeScreen extends StatelessWidget {
  /// HomeScreen constructor
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;

    if (screenwidth < 700) {
      return const HomeScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      return const HomeScreenTablet();
    } else {
      return const HomeScreenDesktop();
    }
  }
}
