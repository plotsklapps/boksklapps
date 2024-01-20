import 'package:boksklapps/widgets/bottombar_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TUTORIAL WORKOUT'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('This is a tutorial workout to get you started with '
                      'BOKSklapps.'),
                ],
              ),
              const Row(
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.stopwatch),
                            title: Text('Set Time'),
                            subtitle: Text('2 minutes'),
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
              const SizedBox(height: 8.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Touch the gloves to learn more about each punch.'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_leadhook'
                        '.png'),
                  ),
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_jab.png'),
                  ),
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_cross.png'),
                  ),
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_rearhook'
                        '.png'),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_leaduppercut'
                        '.png'),
                  ),
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_rearuppercut.png'),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_leadbodyhook.png'),
                  ),
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_bodyjab'
                        '.png'),
                  ),
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_bodycross.png'),
                  ),
                  SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: Image.asset('assets/images/punch_rearbodyhook'
                        '.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) {
                return const TutorialScreen();
              },
            ),
          );
        },
        child: const FaIcon(FontAwesomeIcons.forwardStep),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomBarHomeScreen(),
    );
  }
}
