import 'package:boksklapps/all_imports.dart';

/// RegisterScreenTablet class
class RegisterScreenTablet extends StatefulWidget {
  /// RegisterScreenTablet constructor
  const RegisterScreenTablet({
    super.key,
  });

  @override
  State<RegisterScreenTablet> createState() => RegisterScreenTabletState();
}

/// RegisterScreenTabletState class
class RegisterScreenTabletState extends State<RegisterScreenTablet> {
  /// EmailController
  final TextEditingController emailCtrl = TextEditingController();

  /// PasswordController
  final TextEditingController password1Ctrl = TextEditingController();

  /// PasswordController
  final TextEditingController password2Ctrl = TextEditingController();

  /// Sets default value of passwordVisible to false
  bool isPasswordObscured = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    password1Ctrl.dispose();
    password2Ctrl.dispose();
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
              children: <Row>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    BackToLoginWidget(),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                children: <Widget>[
                  const Text(
                    'REGISTER',
                    style: TextStyleUtils.kHeadline1,
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
                  const SizedBox(height: 12),
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
                  TextField(
                    controller: password2Ctrl,
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
          } else if (password1Ctrl.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password cannot be empty'),
              ),
            );
            return;
          } else if (password2Ctrl.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password cannot be empty'),
              ),
            );
            return;
          } else if (password1Ctrl.text.length < 8) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password 1 must be at least 8 characters'),
              ),
            );
            return;
          } else if (password2Ctrl.text.length < 8) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password 2 must be at least 8 characters'),
              ),
            );
            return;
          } else if (password1Ctrl.text != password2Ctrl.text) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Passwords do not match'),
              ),
            );
          } else {
            await Navigator.pushReplacementNamed(
              context,
              '/home_screen',
            );
          }
        },
        child: IconUtils.kForward,
      ),
    );
  }
}
