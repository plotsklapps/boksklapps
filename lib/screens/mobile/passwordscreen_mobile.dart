import 'package:boksklapps/all_imports.dart';

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
          54,
          18,
          54,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: const <Widget>[
                BackToLoginWidget(),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                children: <Widget>[
                  const Text(
                    'RESET PASSWORD',
                    style: TextStyleUtils.kHeadline1,
                  ),
                  const SizedBox(height: 24),

                  /// Email TextField
                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: StringUtils.kLabelEmail,
                      prefixIcon: IconUtils.kEmailAddress,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await resetPassword(
            context,
            emailCtrl.text,
          );
        },
        child: IconUtils.kForward,
      ),
    );
  }
}
