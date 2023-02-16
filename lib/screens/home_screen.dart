import '../all_imports.dart';

/// HomeScreen class
class HomeScreen extends StatelessWidget {
  /// HomeScreen constructor
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1000) {
      return const HomeScreenMobile();
    } else {
      return const HomeScreenDesktop();
    }
  }
}
