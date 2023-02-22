import 'package:boksklapps/all_imports.dart';

class LoginScreenMobile extends ConsumerStatefulWidget {
  const LoginScreenMobile({
    super.key,
  });

  @override
  ConsumerState<LoginScreenMobile> createState() => LoginScreenMobileState();
}

class LoginScreenMobileState extends ConsumerState<LoginScreenMobile> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  // Sets default value of passwordVisible to true
  bool isPasswordObscured = true;

  @override
  void dispose() {
    // Kill all controllers
    emailCtrl.dispose();
    passwordCtrl.dispose();
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
                            StringUtils.kSignIn,
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

                      // Password TextField
                      TextField(
                        controller: passwordCtrl,
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
                    ],
                  ),
                  Column(
                    children: const <Widget>[
                      // Create an account button
                      GoToRegisterWidget(),
                      SizedBox(height: 24),

                      // Forgot password button
                      ForgotPasswordWidget(),
                      SizedBox(height: 24),

                      // Sneak Peek button (no login)
                      SneakPeekWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Calls loginToFirebase function from firebase_login.dart and
            // handles all the login logic + errors
            await loginToFirebase(
              context,
              ref,
              emailCtrl.text,
              passwordCtrl.text,
            );
          },
          child: IconUtils.kForward,
        ),
      ),
    );
  }
}
