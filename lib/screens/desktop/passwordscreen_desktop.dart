import '../../all_imports.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
            18,
            54,
            18,
            54,
          ),
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
                              'RESET PASSWORD',
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (emailCtrl.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Email cannot be empty'),
                ),
              );
              return;
            } else {
              await Navigator.pushReplacementNamed(
                context,
                '/home_screen',
              );
            }
          },
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
