import '../../all_imports.dart';

/// RegisterScreenDesktop class
class RegisterScreenDesktop extends StatefulWidget {
  /// RegisterScreenDesktop constructor
  const RegisterScreenDesktop({
    super.key,
  });

  @override
  State<RegisterScreenDesktop> createState() => RegisterScreenDesktopState();
}

/// RegisterScreenDesktopState class
class RegisterScreenDesktopState extends State<RegisterScreenDesktop> {
  /// EmailController
  final TextEditingController emailCtrl = TextEditingController();

  /// UsernameController
  final TextEditingController usernameCtrl = TextEditingController();

  /// PasswordController
  final TextEditingController password1Ctrl = TextEditingController();

  /// PasswordController
  final TextEditingController password2Ctrl = TextEditingController();

  /// Sets default value of passwordVisible to false
  bool isPasswordObscured = true;

  @override
  void dispose() {
    /// Kill all controllers
    emailCtrl.dispose();
    usernameCtrl.dispose();
    password1Ctrl.dispose();
    password2Ctrl.dispose();
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
                              'REGISTER',
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
                        const SizedBox(height: 12),

                        /// Username TextField
                        TextField(
                          controller: usernameCtrl,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(
                              Icons.person_outlined,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        /// Password TextField
                        TextField(
                          controller: password1Ctrl,
                          keyboardType: TextInputType.text,
                          obscureText: isPasswordObscured,
                          textAlign: TextAlign.center,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            labelText: StringUtils.kLabelPassword,
                            prefixIcon: IconUtils.kPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordObscured = !isPasswordObscured;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        /// Confirm Password TextField
                        TextField(
                          controller: password2Ctrl,
                          keyboardType: TextInputType.text,
                          obscureText: isPasswordObscured,
                          textAlign: TextAlign.center,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            labelText: StringUtils.kLabelConfirmPassword,
                            prefixIcon: IconUtils.kPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordObscured = !isPasswordObscured;
                                });
                              },
                            ),
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            /// Calls registerToFirebase function from firebase_register.dart
            /// and handles all the registration logic + errors
            await registerToFirebase(
              context,
              emailCtrl.text,
              password1Ctrl.text,
              password2Ctrl.text,
              usernameCtrl.text,
            );
          },
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
