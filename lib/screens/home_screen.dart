import 'package:boksklapps/screens/tutorial_screen.dart';
import 'package:boksklapps/theme/fontstyles.dart';
import 'package:boksklapps/widgets/bottombar_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Hi,', style: FontStyles.fontM),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('\${userName}', style: FontStyles.fontL),
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
                            leading: FaIcon(FontAwesomeIcons.calendarDay),
                            title: Text('\${lastDate}'),
                            subtitle: Text('Last Workout'),
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
                            leading: FaIcon(FontAwesomeIcons.calendarDays),
                            title: Text('\${totalTimes}'),
                            subtitle: Text('Total Workouts'),
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
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[Placeholder()],
                        ),
                      ),
                    ),
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