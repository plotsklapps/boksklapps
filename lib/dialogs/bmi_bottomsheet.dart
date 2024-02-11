import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/signals/showspinner_signal.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetBMI extends StatefulWidget {
  const BottomSheetBMI({
    super.key,
  });

  @override
  State<BottomSheetBMI> createState() {
    return BottomSheetBMIState();
  }
}

class BottomSheetBMIState extends State<BottomSheetBMI> {
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Calculate your BMI', style: TextUtils.fontL),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: FaIcon(FontAwesomeIcons.cakeCandles),
                label: Text('Age in years'),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: FaIcon(FontAwesomeIcons.rulerVertical),
                label: Text('Height in cm'),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: FaIcon(FontAwesomeIcons.weightHanging),
                label: Text('Weight in kg'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('BMI', style: TextUtils.fontXL),
                const SizedBox(width: 16),
                Text(
                  cBMI.value,
                  style: TextUtils.fontXL,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    sSpinnerBMI.value = true;
                    await authService.setAgeInYrs(
                      newAgeInYrs: int.parse(_ageController.text.trim()),
                      onError: _handleErrors,
                      onSuccess: () {},
                    );
                    await authService.setHeightInCm(
                      newHeightInCm: int.parse(_heightController.text.trim()),
                      onError: _handleErrors,
                      onSuccess: () {},
                    );
                    await authService.setWeightInKg(
                      newWeightInKg: int.parse(_weightController.text.trim()),
                      onError: _handleErrors,
                      onSuccess: () {},
                    );
                    await authService.setBMI(
                      newBMI: double.parse(cBMI.value),
                      onError: _handleErrors,
                      onSuccess: _handleSuccess,
                    );
                    sSpinnerBMI.value = false;
                  },
                  child: cSpinnerBMI.watch(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleErrors(String error) {
    Logger().e('Error: $error');
    sSpinnerBMI.value = false;
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  void _handleSuccess() {
    Logger().i('BMI has been calculated and saved.');
    sSpinnerBMI.value = false;
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          'Successfully calculated and saved your BMI: ${cBMI.value}!',
        ),
        showCloseIcon: true,
      ),
    );
  }
}
