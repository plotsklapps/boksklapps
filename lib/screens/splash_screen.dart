import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:boksklapps/all_imports.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

          // Show a boxer GIF as a 'loading indicator'
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
              // What's my name?
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Continuing on a buttonpress might be bad practice,
          // but browsers expect a user interaction when audio
          // on autoplay is involved!
          // See: https://developer.chrome.com/blog/autoplay/
          await onContinuePressed(context, ref);
        },
        label: Row(
          children: const <Widget>[
            Text(
              'CONTINUE',
              style: TextStyleUtils.kHeadline3,
            ),
            SizedBox(width: 8.0),
            IconUtils.kForward,
          ],
        ),
      ),
    );
  }

  Future<void> onContinuePressed(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // Play sound
    await Audio.audioPlayer.play(AssetSource(SoundUtils.kGameboySound));
    if (FirebaseAuth.instance.currentUser != null) {
      Logger().i(
        'UserData fetched from Firestore...',
      );
      if (context.mounted) {
        // If user is NOT null, retrieve Firestore data
        // and go to HomeScreen()
        await getFirestoreData(context, ref).then((_) async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Successfully logged in...',
              ),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
          await Navigator.pushReplacementNamed(
            context,
            '/home_screen',
          );
        });
      } else {
        // If user is null, go to LoginScreen()
        await Navigator.pushReplacementNamed(
          context,
          '/login_screen',
        );
      }
    }
  }
}
