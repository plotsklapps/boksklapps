import 'package:boksklapps/all_imports.dart';

/// LoginScreenMobile class
class LoginScreenMobile extends StatefulWidget {
  /// LoginScreenMobile constructor
  const LoginScreenMobile({
    super.key,
  });

  @override
  State<LoginScreenMobile> createState() => LoginScreenMobileState();
}

/// LoginScreenMobileState class
class LoginScreenMobileState extends State<LoginScreenMobile> {
  /// EmailController
  final TextEditingController emailCtrl = TextEditingController();

  /// PasswordController
  final TextEditingController passwordCtrl = TextEditingController();

  /// Sets default value of passwordVisible to true
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
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    GoToRegisterWidget(),
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <InkWell>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/home_screen',
                        );
                      },
                      child: Animate(
                        effects: <Effect<dynamic>>[
                          FadeEffect(
                            delay: 2000.ms,
                            duration: 1000.ms,
                          ),
                          MoveEffect(
                            delay: 2500.ms,
                            duration: 1000.ms,
                          ),
                        ],
                        child: const Text(
                          'Sneak Peek',
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
                children: [
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
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                email: emailCtrl.text,
                password: passwordCtrl.text,
              )
                  .then((currentUser) async {
                await Navigator.pushReplacementNamed(
                  context,
                  '/home_screen',
                );
              });
            } on PlatformException catch (error) {
              switch (error.code) {
                case 'ERROR_INVALID_EMAIL':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Emailaddress unknown, please verify',
                      ),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                  break;
                case 'ERROR_WRONG_PASSWORD':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Wrong password, please verify',
                      ),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                  break;
                case 'ERROR_USER_NOT_FOUND':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'User not found, try registering',
                      ),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                  break;
                case 'ERROR_USER_DISABLED':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'User disabled, please contact plotsklapps@gmail.com',
                      ),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                  break;
                case 'ERROR_TOO_MANY_REQUESTS':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Server busy, please try again later',
                      ),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                  break;
                case 'ERROR_OPERATION_NOT_ALLOWED':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Operation not allowed, please try again later',
                      ),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                  break;
                default:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Unexpected error, please try again later or contact '
                        'plotsklapps@gmail.com',
                      ),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                  break;
              }
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Unexpected error, please try again later or contact '
                    'plotsklapps@gmail.com',
                  ),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                ),
              );
            }
          }
        },
        child: IconUtils.kForward,
      ),
    );
  }
}
