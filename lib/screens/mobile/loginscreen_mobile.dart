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
          children: <Widget>[
            Column(
              children: <Widget>[
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
          await loginToFirebase();
        },
        child: IconUtils.kForward,
      ),
    );
  }

  /// Login to Firebase method including all error handling
  Future<void> loginToFirebase() async {
    if (emailCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email cannot be empty, please enter your email',
          ),
        ),
      );
      return;
    } else if (passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password cannot be empty, please enter your password',
          ),
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
        Logger().i('Logging in with email: ${emailCtrl.text}');
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailCtrl.text,
          password: passwordCtrl.text,
        )
            .then((UserCredential currentUser) async {
          await Navigator.pushReplacementNamed(
            context,
            '/home_screen',
          );
        });
      } on FirebaseAuthException catch (error) {
        if (error.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'An account already exists with the same emailaddress,'
                ' but different sign-in credentials',
              ),
            ),
          );
        } else if (error.code == 'app-not-authorized') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The app is not authorized to use Firebase '
                'Authentication',
              ),
            ),
          );
        } else if (error.code == 'credential-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The account corresponding to the emailaddress '
                'already exists with different sign-in credentials',
              ),
            ),
          );
        } else if (error.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The email address is already in use by another account',
              ),
            ),
          );
        } else if (error.code == 'internal-error') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'An internal error has occurred, please try again later',
              ),
            ),
          );
        } else if (error.code == 'invalid-argument') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'An invalid argument was provided, please try again '
                'later',
              ),
            ),
          );
        } else if (error.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The credential data is malformed or has expired',
              ),
            ),
          );
        } else if (error.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The emailaddress is invalid or badly formatted',
              ),
            ),
          );
        } else if (error.code == 'invalid-verification-code') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The verification code is invalid or has expired',
              ),
            ),
          );
        } else if (error.code == 'invalid-verification-id') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The verification ID is invalid or has expired',
              ),
            ),
          );
        } else if (error.code == 'network-request-failed') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'A network error (such as timeout, interrupted connection '
                'or unreachable host) has occurred',
              ),
            ),
          );
        } else if (error.code == 'no-such-provider') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No such provider exists',
              ),
            ),
          );
        } else if (error.code == 'operation-not-allowed') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The given sign-in provider is disabled for this Firebase '
                'project',
              ),
            ),
          );
        } else if (error.code == 'provider-already-linked') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'User is already linked to the provider',
              ),
            ),
          );
        } else if (error.code == 'quota-exceeded') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The quota for this operation has been exceeded',
              ),
            ),
          );
        } else if (error.code == 'requires-recent-login') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'This operation is sensitive and requires recent '
                'authentication. Log in again before retrying '
                'this request',
              ),
            ),
          );
        } else if (error.code == 'too-many-requests') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'We have blocked all requests from this device due to '
                'unusual activity. Try again later',
              ),
            ),
          );
        } else if (error.code == 'user-disabled') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The user account has been disabled by an administrator',
              ),
            ),
          );
        } else if (error.code == 'user-mismatch') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The supplied credentials do not correspond to the '
                'previously signed in user',
              ),
            ),
          );
        } else if (error.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'There is no user corresponding to the given email',
              ),
            ),
          );
        } else if (error.code == 'user-token-expired') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "The user's credential is no longer valid. "
                'The user must sign in again',
              ),
            ),
          );
        } else if (error.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'The password must be 6 characters long or more',
              ),
            ),
          );
        } else if (error.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong password provided for that user'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Unexpected error: $error',
              ),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Unexpected error: $error',
            ),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }
}
