// import 'package:boksklapps/all_imports.dart';

// // Shows a dialog to change the totalTimer, setTimer,
// // and restTimer and store it to Firestore
// Future<void> showChangeTimersDialog(
//   BuildContext context,
// ) async {
//   // Show the dialog
//   await showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       final TextEditingController totalTimerCtrl = TextEditingController();
//       final TextEditingController setTimerCtrl = TextEditingController();
//       final TextEditingController restTimerCtrl = TextEditingController();

//       // Return Consumer() to gain access to the Providers
//       return Consumer(
//         builder: (BuildContext context, WidgetRef ref, _) {
//           return AlertDialog(
//             title: const Text(
//               'Set Boxing Timers',
//             ),
//             content: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 const Text('Total time in minutes'),

//                 // Age Textfield (watches ageProvider)
//                 TextField(
//                   controller: totalTimerCtrl,
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     labelText: 'Mock Input',
//                     prefixIcon: const Icon(
//                       Icons.timelapse_outlined,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 const Text('Set time in minutes'),

//                 // Height Textfield (watches heightProvider)
//                 TextField(
//                   controller: setTimerCtrl,
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     labelText: 'Mock Input',
//                     prefixIcon: const Icon(
//                       Icons.timer_outlined,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 const Text('Weight in kg'),

//                 // Weight Textfield (watches weightProvider)
//                 TextField(
//                   controller: restTimerCtrl,
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     labelText: 'Mock Input',
//                     prefixIcon: const Icon(
//                       Icons.bedroom_parent_outlined,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             actions: <TextButton>[
//               TextButton(
//                 child: const Text(
//                   'Cancel',
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: const Text(
//                   'Save',
//                 ),
//                 onPressed: () async {
//                   Logger().i(
//                     'Saving totalTimer, setTimer, restTimer to Firestore...',
//                   );
//                   // Store values to Firestore database via
//                   // their corresponding Providers and pop the dialog
//                   await ref
//                       .read(totalTimerNotifier.notifier)
//                       .updateTotalTimerDuration(
//                         context,
//                         ref,
//                         totalTimerCtrl.text,
//                       )
//                       .then(
//                     (_) async {
//                       await ref
//                           .read(setTimerProvider.notifier)
//                           .updateSetTimer(
//                             context,
//                             ref,
//                             setTimerCtrl.text,
//                           )
//                           .then((_) async {
//                         await ref
//                             .read(restTimerProvider.notifier)
//                             .updateRestTimer(
//                               context,
//                               ref,
//                               restTimerCtrl.text,
//                             );
//                       }).then((_) async {
//                         // Show a snackbar to confirm that the values have been
//                         // updated and pop the dialog
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: const Text(
//                               'Age, height, weight and BMI updated...',
//                             ),
//                             action: SnackBarAction(
//                               label: 'OK',
//                               onPressed: () {},
//                             ),
//                           ),
//                         );
//                         Navigator.of(context).pop();
//                       });
//                     },
//                   );
//                 },
//               )
//             ],
//           );
//         },
//       );
//     },
//   );
// }
