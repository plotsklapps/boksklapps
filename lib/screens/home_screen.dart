import 'package:boksklapps/dialogs/usersettings_bottomsheet.dart';
import 'package:boksklapps/navigation.dart';
import 'package:boksklapps/providers/displayname_provider.dart';
import 'package:boksklapps/providers/lastvisit_provider.dart';
import 'package:boksklapps/providers/sneakpeek_provider.dart';
import 'package:boksklapps/providers/totalworkouts_provider.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                  // Watching a computed signal to provide the
                  // corresponding displayName.
                  Text(ref.watch(displayNameProvider), style: TextUtils.fontL),
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
                            leading: const FaIcon(FontAwesomeIcons.calendarDay),
                            title: Text(ref.watch(lastVisitProvider)),
                            subtitle: const Text('Last Workout'),
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
                            leading:
                                const FaIcon(FontAwesomeIcons.calendarDays),
                            title: Text(
                              ref.watch(totalWorkoutsProvider).toString(),
                            ),
                            subtitle: const Text('Total Workouts'),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // The following code should be used after finishing a workout,
            // not before. But for now, it's here to demonstrate how to
            // update the last visit date and total workouts.
            if (!ref.watch(sneakPeekProvider)) {
              await ref.read(lastVisitProvider.notifier).setLastVisit();
              await ref.read(totalWorkoutsProvider.notifier).setTotalWorkouts();
            }

            // Navigate to TutorialScreen.
            if (context.mounted) {
              Navigate.toTutorialScreen(context);
            }
          },
          child: const FaIcon(FontAwesomeIcons.forwardStep),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: const BottomBarIcon(
          hasLeading: false,
          icon: FontAwesomeIcons.barsProgress,
          bottomSheet: BottomSheetUserSettings(),
        ),
      ),
    );
  }
}
