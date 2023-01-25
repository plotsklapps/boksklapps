import 'package:boksklapps/all_imports.dart';

/// PasswordScreen class
class PasswordScreen extends StatelessWidget {
  /// PasswordScreen constructor
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1000) {
      return const PasswordScreenMobile();
    } else {
      return const PasswordScreenDesktop();
    }
  }
}

/// PasswordScreenMobile class
class PasswordScreenMobile extends StatefulWidget {
  /// PasswordScreenMobile constructor
  const PasswordScreenMobile({
    super.key,
  });

  @override
  State<PasswordScreenMobile> createState() => PasswordScreenMobileState();
}

/// PasswordScreenMobileState class
class PasswordScreenMobileState extends State<PasswordScreenMobile> {
  /// EmailController
  final TextEditingController emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          18,
          64,
          18,
          56,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/login_screen',
                        );
                      },
                      child: const Text(
                        'Back to Login',
                        style: TextStyleUtils.kHeadline3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                children: [
                  const Text(
                    'RESET PASSWORD',
                    style: TextStyleUtils.kHeadline1,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Emailaddress',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            '/home_screen',
          );
        },
        child: IconUtils.kForward,
      ),
    );
  }
}

/// PasswordScreenDesktop class
class PasswordScreenDesktop extends StatefulWidget {
  /// PasswordScreenDesktop constructor
  const PasswordScreenDesktop({
    super.key,
  });

  @override
  State<PasswordScreenDesktop> createState() => PasswordScreenDesktopState();
}

/// PasswordScreenDesktopState class
class PasswordScreenDesktopState extends State<PasswordScreenDesktop> {
  /// EmailController
  final TextEditingController emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 4,
          64,
          MediaQuery.of(context).size.width / 4,
          56,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/login_screen',
                        );
                      },
                      child: const Text(
                        'Back to Login',
                        style: TextStyleUtils.kHeadline3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                children: [
                  const Text(
                    'RESET PASSWORD',
                    style: TextStyleUtils.kHeadline1,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Emailaddress',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fabPassword',
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            '/home_screen',
          );
        },
        child: IconUtils.kForward,
      ),
    );
  }
}
