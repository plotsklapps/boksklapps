import 'package:boksklapps/providers/displayname_provider.dart';
import 'package:boksklapps/screens/tutorial_screen.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String displayName = ref.watch(displayNameProvider);
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Row(
                children: <Widget>[
                  Text('Hi,', style: TextUtils.fontM),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(displayName, style: TextUtils.fontL),
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
                            leading: FaIcon(FontAwesomeIcons.calendarDay),
                            title: Text(r'${lastDate}'),
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
                            title: Text(r'${totalTimes}'),
                            subtitle: Text('Total Workouts'),
                          ),
                        ],
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
      bottomNavigationBar: const BottomBar(),
    );
  }
}
