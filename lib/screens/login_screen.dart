import 'package:boksklapps/all_imports.dart';

/// LoginScreen class
class LoginScreen extends ConsumerStatefulWidget {
  /// LoginScreen constructor
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('Create an account', style: TextStyleUtils.kHeadline3),
              SizedBox(height: 12),
              Text('Forgot password?', style: TextStyleUtils.kHeadline3),
            ],
          ),
          Column(
            children: [
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  hintText: 'Emailaddress',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordCtrl,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
