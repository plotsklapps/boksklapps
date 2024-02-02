import 'package:boksklapps/screens/tutorialworkout_screen.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:boksklapps/widgets/punch_glove.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TUTORIAL WORKOUT'),
        ),
        body: const Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'This is a tutorial workout to get you started with '
                      'BOKSklapps.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.mugHot),
                            title: Text('Warm Up'),
                            subtitle: Text('5 minutes'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.solidClock),
                            title: Text('Total Time'),
                            subtitle: Text('30 minutes'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.stopwatch),
                            title: Text('Set Time'),
                            subtitle: Text('1 minute'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.bed),
                            title: Text('Rest Time'),
                            subtitle: Text('30 seconds'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Touch the gloves to learn more about '
                      'each punch.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PunchGlove(
                    punchNumber: '3',
                    punchName: 'Lead Hook',
                    punchGIF: 'assets/GIF/leadHook.gif',
                    punchPNG: 'assets/images/punch_leadhook.png',
                  ),
                  PunchGlove(
                    punchNumber: '1',
                    punchName: 'Jab',
                    punchGIF: 'assets/GIF/jab.gif',
                    punchPNG: 'assets/images/punch_jab.png',
                  ),
                  PunchGlove(
                    punchNumber: '2',
                    punchName: 'Cross',
                    punchGIF: 'assets/GIF/cross.gif',
                    punchPNG: 'assets/images/punch_cross.png',
                  ),
                  PunchGlove(
                    punchNumber: '4',
                    punchName: 'Rear Hook',
                    punchGIF: 'assets/GIF/rearHook.gif',
                    punchPNG: 'assets/images/punch_rearhook.png',
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PunchGlove(
                    punchNumber: '5',
                    punchName: 'Lead Uppercut',
                    punchGIF: 'assets/GIF/leadUppercut.gif',
                    punchPNG: 'assets/images/punch_leaduppercut.png',
                  ),
                  PunchGlove(
                    punchNumber: '6',
                    punchName: 'Rear Uppercut',
                    punchGIF: 'assets/GIF/rearUppercut.gif',
                    punchPNG: 'assets/images/punch_rearuppercut.png',
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PunchGlove(
                    punchNumber: '3B',
                    punchName: 'Lead Body Hook',
                    punchGIF: 'assets/GIF/leadBodyHook.gif',
                    punchPNG: 'assets/images/punch_leadbodyhook.png',
                  ),
                  PunchGlove(
                    punchNumber: '1B',
                    punchName: 'Body Jab',
                    punchGIF: 'assets/GIF/bodyJab.gif',
                    punchPNG: 'assets/images/punch_bodyjab.png',
                  ),
                  PunchGlove(
                    punchNumber: '2B',
                    punchName: 'Body Cross',
                    punchGIF: 'assets/GIF/bodyCross.gif',
                    punchPNG: 'assets/images/punch_bodycross.png',
                  ),
                  PunchGlove(
                    punchNumber: '4B',
                    punchName: 'Rear Body Hook',
                    punchGIF: 'assets/GIF/rearBodyHook.gif',
                    punchPNG: 'assets/images/punch_rearbodyhook.png',
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'BOKSklapps is audio orientated, so you can keep '
                      'you eyes on the bag. The voice will guide you '
                      'through the workout.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) {
                  return const TutorialWorkoutScreen();
                },
              ),
            );
          },
          child: const FaIcon(FontAwesomeIcons.forwardStep),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}
