import 'package:boksklapps/all_imports.dart';

class PasswordScreenMobile extends ConsumerStatefulWidget {
  const PasswordScreenMobile({
    super.key,
  });

  @override
  ConsumerState<PasswordScreenMobile> createState() =>
      PasswordScreenMobileState();
}

class PasswordScreenMobileState extends ConsumerState<PasswordScreenMobile> {
  final TextEditingController emailCtrl = TextEditingController();

  @override
  void dispose() {
    // Kill all controllers
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              54,
              18,
              54,
            ),
            // Wrap the Column() in a SizedBox() to set the total height
            // at 85% of the screen height so that the SingleChildScrollView()
            // won't affect any of the widgets inside the Column()
            // and the keyboard can easily pop up without any issues
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Text>[
                          Text(
                            StringUtils.kForgotPassword,
                            style: TextStyleUtils.kHeadline1,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Email TextField
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
                      // Back to login button
                      BackToLoginWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await resetPassword(
              context,
              ref,
              emailCtrl.text,
            );
          },
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
