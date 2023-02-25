import 'package:boksklapps/all_imports.dart';

class PasswordScreenTablet extends ConsumerStatefulWidget {
  const PasswordScreenTablet({
    super.key,
  });

  @override
  ConsumerState<PasswordScreenTablet> createState() =>
      PasswordScreenTabletState();
}

class PasswordScreenTabletState extends ConsumerState<PasswordScreenTablet> {
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
            // Wrap the Row() in a SizedBox() to set the total height
            // at 85% of the screen height so that the SingleChildScrollView()
            // won't affect any of the widgets inside the Row()
            // and the keyboard can easily pop up without any issues
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        GetShitDoneWidget(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
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
                            BackToLoginWidget(),
                          ],
                        ),
                      ],
                    ),
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
