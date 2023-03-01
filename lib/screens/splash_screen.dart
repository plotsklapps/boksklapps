import 'dart:async';

import 'package:boksklapps/all_imports.dart';

// SplashScreen class
class SplashScreen extends ConsumerStatefulWidget {
  // SplashScreen constructor
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // Declare timer, use it in initState and dispose
  // After 5 seconds, navigate to home if user is known,
  // else navigate to login
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 5), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        Logger().i(
          'UserData fetched from Firestore...',
        );
        // If user is NOT null, retrieve Firestore data
        // and go to HomeScreen()
        await getFirestoreData(context, ref).then((_) async {
          await Navigator.pushReplacementNamed(
            context,
            '/home_screen',
          );
        });
      } else {
        await Navigator.pushReplacementNamed(
          context,
          '/login_screen',
        );
      }
    });
  }

  @override
  void dispose() {
    // Kill timer
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Animate>[
              // Animate BOKS part
              Animate(
                effects: <Effect<dynamic>>[
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

              // Animate klapps part
              Animate(
                effects: <Effect<dynamic>>[
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
            children: <Animate>[
              // Animate - Sparring Partner - part
              Animate(
                effects: <Effect<dynamic>>[
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

          // Show a dummy progress indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <CircularProgressIndicator>[
              CircularProgressIndicator(
                strokeWidth: 14,
              ),
            ],
          ),
          const SizedBox(height: 64),

          // What's my name?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Text>[
              Text(
                StringUtils.kCreatedBy,
                style: TextStyleUtils.kBodyText,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Image>[
              Image(
                image: AssetImage(
                  'assets/PNG/plotsklappsLogo.png',
                ),
                width: 200,
                height: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
