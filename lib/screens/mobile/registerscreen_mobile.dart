import 'package:boksklapps/all_imports.dart';

/// RegisterScreenMobile class
class RegisterScreenMobile extends StatefulWidget {
  /// RegisterScreenMobile constructor
  const RegisterScreenMobile({
    super.key,
  });

  @override
  State<RegisterScreenMobile> createState() => RegisterScreenMobileState();
}

/// RegisterScreenMobileState class
class RegisterScreenMobileState extends State<RegisterScreenMobile> {
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
    emailCtrl.dispose();
    usernameCtrl.dispose();
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
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailCtrl.text,
              password: password1Ctrl.text,
            );
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .set(<String, String>{
              'userEmail': emailCtrl.text,
              'userName': usernameCtrl.text,
            });
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Account and Database created'),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                ),
              );
            }
            if (context.mounted) {
              await Navigator.pushReplacementNamed(
                context,
                '/login_screen',
              );
            }
          }
        },
        child: IconUtils.kForward,
      ),
    );
  }
}
