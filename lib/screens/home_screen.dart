import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/screens/tutorial_screen.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

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
                  Text(cDisplayName.watch(context), style: TextUtils.fontL),
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
                            title: Text(sLastVisitDate.watch(context)),
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
                            title:
                                Text(sTotalWorkouts.watch(context).toString()),
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
            if (!sSneakPeeker.value) {
              // The following code should be used after finishing a workout,
              // not before. But for now, it's here to demonstrate how to
              // update the last visit date and total workouts.
              final String newLastVisitDate =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              await authService.setLastVisitDate(
                newLastVisitDate: newLastVisitDate,
                onError: _handleErrors,
                onSuccess: () async {
                  await authService.setTotalWorkouts(
                    onError: _handleErrors,
                    onSuccess: () {
                      _handleSuccess(context);
                    },
                  );
                },
              );
            } else {
              _handleSuccess(context);
            }
          },
          child: const FaIcon(FontAwesomeIcons.forwardStep),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }

  void _handleErrors(String error) {
    Logger().e('Error: $error');
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  void _handleSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) {
          return const TutorialScreen();
        },
      ),
    );
  }
}
