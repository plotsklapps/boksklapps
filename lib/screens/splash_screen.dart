import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:boksklapps/all_imports.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    Future<void>.microtask(() async {
      await audioPlayer.dispose();
    });
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
          const SizedBox(height: 32),

          // Show a boxer GIF as a loading indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Image(
                image: AssetImage(
                  'assets/GIF/boxer.gif',
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await onContinuePressed();
        },
        child: Row(
          children: const <Widget>[
            Text(
              'CONTINUE',
            ),
            IconUtils.kForward,
          ],
        ),
      ),
    );
  }

  Future<void> onContinuePressed() async {
    await audioPlayer.play(AssetSource(SoundUtils.kGameboySound));
    if (FirebaseAuth.instance.currentUser != null) {
      Logger().i(
        'UserData fetched from Firestore...',
      );
      // If user is NOT null, retrieve Firestore data
      // and go to HomeScreen()
      if (context.mounted) {
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
    }
  }
}
