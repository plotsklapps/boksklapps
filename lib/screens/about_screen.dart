import 'package:boksklapps/all_imports.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
