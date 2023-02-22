import 'package:boksklapps/all_imports.dart';

class PasswordScreenDesktop extends ConsumerStatefulWidget {
  const PasswordScreenDesktop({
    super.key,
  });

  @override
  ConsumerState<PasswordScreenDesktop> createState() =>
      PasswordScreenDesktopState();
}

class PasswordScreenDesktopState extends ConsumerState<PasswordScreenDesktop> {
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
                    child: Drawer(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 220,
                            child: DrawerHeader(
                              child: Column(
                                children: <Row>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Animate>[
                                      Animate(
                                        effects: <Effect<dynamic>>[
                                          ScaleEffect(
                                            delay: 0.ms,
                                            duration: 800.ms,
                                          ),
                                        ],
                                        child: const Text(
                                          StringUtils.kBoks,
                                          style: TextStyleUtils.kLogo1,
                                        ),
                                      ),
                                      Animate(
                                        effects: <Effect<dynamic>>[
                                          ScaleEffect(
                                            delay: 800.ms,
                                            duration: 800.ms,
                                          ),
                                        ],
                                        child: const Text(
                                          StringUtils.kKlapps,
                                          style: TextStyleUtils.kLogo2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Animate>[
                                      Animate(
                                        effects: <Effect<dynamic>>[
                                          FadeEffect(
                                            delay: 1600.ms,
                                            duration: 800.ms,
                                          ),
                                        ],
                                        child: const Text(
                                          StringUtils.kSparringPartner,
                                          style: TextStyleUtils.kHeadline2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Row>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            GetShitDoneWidget(),
                          ],
                        ),
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
