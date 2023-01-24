import 'dart:async';
import 'package:boksklapps/all_imports.dart';

/// SplashScreen class
class SplashScreen extends ConsumerStatefulWidget {
  /// SplashScreen constructor
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home_screen');
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Animate(
                effects: [
                  ScaleEffect(
                    delay: 0.ms,
                    duration: 800.ms,
                  ),
                ],
                child: const Text(
                  StringUtils.kBoks,
                  style: TextStyleUtils.kLogo1,
                ),
              ),
              Animate(
                effects: [
                  ScaleEffect(
                    delay: 800.ms,
                    duration: 800.ms,
                  ),
                ],
                child: const Text(
                  StringUtils.kKlapps,
                  style: TextStyleUtils.kLogo2,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Animate(
                effects: [
                  FadeEffect(
                    delay: 1600.ms,
                    duration: 800.ms,
                  ),
                ],
                child: const Text(
                  StringUtils.kSparringPartner,
                  style: TextStyleUtils.kHeadline2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                strokeWidth: 14,
              ),
            ],
          ),
          const SizedBox(height: 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                StringUtils.kCreatedBy,
                style: TextStyleUtils.kBodyText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
