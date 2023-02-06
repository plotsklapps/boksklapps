import 'package:boksklapps/all_imports.dart';

/// LoginScreen class
class LoginScreen extends StatelessWidget {
  /// LoginScreen constructor
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1000) {
      return const LoginScreenMobile();
    } else {
      return const LoginScreenDesktop();
    }
  }
}

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
          children: [
            Column(
              children: [
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

/// LoginScreenDesktop class
class LoginScreenDesktop extends StatefulWidget {
  /// LoginScreenDesktop constructor
  const LoginScreenDesktop({
    super.key,
  });

  @override
  State<LoginScreenDesktop> createState() => LoginScreenDesktopState();
}

/// LoginScreenDesktopState class
class LoginScreenDesktopState extends State<LoginScreenDesktop> {
  /// EmailController
  final TextEditingController emailCtrl = TextEditingController();

  /// PasswordController
  final TextEditingController passwordCtrl = TextEditingController();

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
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 4,
          64,
          MediaQuery.of(context).size.width / 4,
          56,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <InkWell>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/register_screen',
                        );
                      },
                      child: const Text(
                        StringUtils.kCreateAccount,
                        style: TextStyleUtils.kHeadline3,
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
                      child: const Text(
                        StringUtils.kForgotPassword,
                        style: TextStyleUtils.kHeadline3,
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
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passwordCtrl,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    enableSuggestions: false,
                    decoration: const InputDecoration(
                      labelText: StringUtils.kLabelPassword,
                      prefixIcon: Icon(
                        Icons.lock_outlined,
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
