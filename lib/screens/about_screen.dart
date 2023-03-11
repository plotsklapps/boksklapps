import 'package:boksklapps/all_imports.dart';
import 'package:boksklapps/screens/mobile/aboutscreen_mobile.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;

    if (screenwidth < 700) {
      return const AboutScreenMobile();
    } else if (screenwidth >= 700 && screenwidth < 1300) {
      return const AboutScreenMobile();
    } else {
      return const AboutScreenMobile();
    }
  }
}
