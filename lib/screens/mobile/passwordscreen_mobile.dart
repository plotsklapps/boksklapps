import '../../all_imports.dart';

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
    return SafeArea(
      child: Scaffold(
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
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Text>[
                      Text(
                        'RESET PASSWORD',
                        style: TextStyleUtils.kHeadline1,
                      ),
                    ],
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
              Column(
                children: const <Widget>[
                  /// Back to login button
                  BackToLoginWidget(),
                ],
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
      ),
    );
  }
}
