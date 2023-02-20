import 'package:boksklapps/all_imports.dart';

/// RegisterScreenMobile class
class RegisterScreenMobile extends ConsumerStatefulWidget {
  /// RegisterScreenMobile constructor
  const RegisterScreenMobile({
    super.key,
  });

  @override
  ConsumerState<RegisterScreenMobile> createState() =>
      RegisterScreenMobileState();
}

/// RegisterScreenMobileState class
class RegisterScreenMobileState extends ConsumerState<RegisterScreenMobile> {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              54,
              18,
              54,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
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
                      const SizedBox(height: 12),

                      // Username TextField
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

                      // Password TextField
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

                      // Confirm Password TextField
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
            // Calls registerToFirebase function from firebase_register.dart
            // and handles all the registration logic + errors
            await registerToFirebase(
              context,
              ref,
              emailCtrl.text,
              usernameCtrl.text,
              password1Ctrl.text,
              password2Ctrl.text,
            );
          },
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
