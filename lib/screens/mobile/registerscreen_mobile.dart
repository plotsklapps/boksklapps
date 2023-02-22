import 'package:boksklapps/all_imports.dart';

class RegisterScreenMobile extends ConsumerStatefulWidget {
  const RegisterScreenMobile({
    super.key,
  });

  @override
  ConsumerState<RegisterScreenMobile> createState() =>
      RegisterScreenMobileState();
}

class RegisterScreenMobileState extends ConsumerState<RegisterScreenMobile> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController password1Ctrl = TextEditingController();
  final TextEditingController password2Ctrl = TextEditingController();

  // Sets default value of passwordVisible to false
  bool isPasswordObscured = true;

  @override
  void dispose() {
    // Kill all controllers
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
                            StringUtils.kSignUp,
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
                          labelText: StringUtils.kUserName,
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
