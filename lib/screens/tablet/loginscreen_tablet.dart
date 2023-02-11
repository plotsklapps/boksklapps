import 'package:boksklapps/all_imports.dart';

/// LoginScreenTablet class
class LoginScreenTablet extends StatefulWidget {
  /// LoginScreenTablet constructor
  const LoginScreenTablet({
    super.key,
  });

  @override
  State<LoginScreenTablet> createState() => LoginScreenTabletState();
}

/// LoginScreenTabletState class
class LoginScreenTabletState extends State<LoginScreenTablet> {
  /// EmailController
  final TextEditingController emailCtrl = TextEditingController();

  /// PasswordController
  final TextEditingController passwordCtrl = TextEditingController();

  /// Sets default value of passwordVisible to false
  bool isPasswordObscured = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
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
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/register_screen',
                        );
                      },
                      child: Animate(
                        effects: <Effect<dynamic>>[
                          FadeEffect(
                            delay: 0.ms,
                            duration: 1000.ms,
                          ),
                          MoveEffect(
                            delay: 500.ms,
                            duration: 1000.ms,
                          ),
                        ],
                        child: const Text(
                          StringUtils.kCreateAccount,
                          style: TextStyleUtils.kHeadline3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <InkWell>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/password_screen',
                        );
                      },
                      child: Animate(
                        effects: <Effect<dynamic>>[
                          FadeEffect(
                            delay: 1000.ms,
                            duration: 1000.ms,
                          ),
                          MoveEffect(
                            delay: 1500.ms,
                            duration: 1000.ms,
                          ),
                        ],
                        child: const Text(
                          StringUtils.kForgotPassword,
                          style: TextStyleUtils.kHeadline3,
                        ),
                      ),
                    ),
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
                    'LOGIN',
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
          } else if (passwordCtrl.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password cannot be empty'),
              ),
            );
            return;
          } else if (passwordCtrl.text.length < 8) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password must be at least 8 characters'),
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
    );
  }
}
