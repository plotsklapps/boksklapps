import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
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

  final Signal<bool> _sShowSpinner = signal<bool>(false);

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
    final Computed<Widget> cSpinner = computed<Widget>(() {
      return _sShowSpinner.value
          ? const CircularProgressIndicator(strokeWidth: 6)
          : const FaIcon(FontAwesomeIcons.forwardStep);
    });
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
            const Text('BMI', style: TextUtils.fontL),
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
                  label: Text('Height in cm'),),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  icon: FaIcon(FontAwesomeIcons.weightHanging),
                  label: Text('Weight in kg'),),
            ),
            const SizedBox(height: 16),
            Text(
              'BMI: ${cBMI.value}',
              style: TextUtils.fontXL,
              textAlign: TextAlign.center,
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
                    _sShowSpinner.value = true;
                    await authService.setAgeInYrs(
                      newAgeInYrs: int.parse(_ageController.text.trim()),
                      onError: _handleErrors,
                      onSuccess: _handleSuccess,
                    );
                    await authService.setHeightInCm(
                      newHeightInCm: int.parse(_heightController.text.trim()),
                      onError: _handleErrors,
                      onSuccess: _handleSuccess,
                    );
                    await authService.setWeightInKg(
                      newWeightInKg: int.parse(_weightController.text.trim()),
                      onError: _handleErrors,
                      onSuccess: _handleSuccess,
                    );
                    await authService.setBMI(
                      newBMI: double.parse(cBMI.value),
                      onError: _handleErrors,
                      onSuccess: _handleSuccess,
                    );
                    _sShowSpinner.value = false;
                  },
                  child: cSpinner.watch(context),
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
    _sShowSpinner.value = false;
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        showCloseIcon: true,
      ),
    );
  }

  void _handleSuccess() {
    Logger().i('User has changed their displayName.');
    _sShowSpinner.value = false;
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text(
          'You have successfully changed your username.',
        ),
        showCloseIcon: true,
      ),
    );
  }
}
