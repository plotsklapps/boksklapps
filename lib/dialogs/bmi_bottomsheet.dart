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
  final GlobalKey<FormState> bmiFormKey = GlobalKey<FormState>();
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
            Form(
              key: bmiFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid age.';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      sAgeInYrs.value = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.cakeCandles),
                      ),
                      label: Text('Age in years'),
                    ),
                  ),
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid height.';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      sHeightInCm.value = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.rulerVertical),
                      ),
                      label: Text('Height in centimeters'),
                    ),
                  ),
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid weight.';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      sWeightInKg.value = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: SizedBox(
                        width: 24,
                        child: FaIcon(FontAwesomeIcons.weightHanging),
                      ),
                      label: Text('Weight in kilograms'),
                    ),
                  ),
                ],
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
                    sSpinnerBMI.value = false;
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    sSpinnerBMI.value = true;
                    if (bmiFormKey.currentState!.validate()) {
                      rootScaffoldMessengerKey.currentState!.showSnackBar(
                        const SnackBar(content: Text('Processing Data...')),
                      );
                      await authService.setAgeInYrs(
                        newAgeInYrs: sAgeInYrs.value,
                        onError: _handleErrors,
                        onSuccess: () {},
                      );
                      await authService.setHeightInCm(
                        newHeightInCm: sHeightInCm.value,
                        onError: _handleErrors,
                        onSuccess: () {},
                      );
                      await authService.setWeightInKg(
                        newWeightInKg: sWeightInKg.value,
                        onError: _handleErrors,
                        onSuccess: () {},
                      );
                      await authService.setBMI(
                        newBMI: double.parse(cBMI.value),
                        onError: _handleErrors,
                        onSuccess: _handleSuccess,
                      );
                      sSpinnerBMI.value = false;
                    } else {
                      sSpinnerBMI.value = false;
                    }
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
