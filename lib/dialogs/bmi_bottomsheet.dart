import 'package:boksklapps/auth_service.dart';
import 'package:boksklapps/main.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/theme_provider.dart';
import 'package:boksklapps/signals/firebase_signals.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/flexcolors.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';

class BottomSheetBMI extends ConsumerStatefulWidget {
  const BottomSheetBMI({
    super.key,
  });

  @override
  ConsumerState<BottomSheetBMI> createState() {
    return BottomSheetBMIState();
  }
}

class BottomSheetBMIState extends ConsumerState<BottomSheetBMI> {
  // Custom authentification service for easier access to Firebase functions.
  // See auth_service.dart for more details.
  final AuthService _authService = AuthService();

  // Validation key for the form textfields.
  final GlobalKey<FormState> _bmiFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: bottomSheetPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(title: 'Calculate your BMI'),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Form(
              key: _bmiFormKey,
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
                  ).animate().fade().moveX(delay: 200.ms, begin: -32),
                  const SizedBox(height: 8),
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
                  )
                      .animate()
                      .fade(delay: 200.ms)
                      .moveX(delay: 400.ms, begin: -32),
                  const SizedBox(height: 8),
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
                  )
                      .animate()
                      .fade(delay: 400.ms)
                      .moveX(delay: 600.ms, begin: -32),
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
                  cBMI.watch(context),
                  style: TextUtils.fontXL,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Cancel the spinner and pop the bottomsheet.
                    ref.read(spinnerProvider.notifier).cancelSpinner();
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () async {
                    await _validateAndCalculate();
                  },
                  child: ref.watch(spinnerProvider),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateAndCalculate() async {
    // Show the spinner while the bmi is begin calculated.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Validate the form and save the values.
    final FormState? bmiForm = _bmiFormKey.currentState;
    if (bmiForm!.validate()) {
      bmiForm.save();

      // Show a SnackBar to the user to indicate that the data is being
      // processed.
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(content: Text('Processing Data...')),
      );
      await _authService.setAgeInYrs(
        newAgeInYrs: sAgeInYrs.value,
        onError: (String error) {
          _handleErrors(error, ref);
        },
        onSuccess: () {
          // Do nothing, just continue to next step.
        },
      );
      await _authService.setHeightInCm(
        newHeightInCm: sHeightInCm.value,
        onError: (String error) {
          _handleErrors(error, ref);
        },
        onSuccess: () {
          // Do nothing, just continue to next step.
        },
      );
      await _authService.setWeightInKg(
        newWeightInKg: sWeightInKg.value,
        onError: (String error) {
          _handleErrors(error, ref);
        },
        onSuccess: () {
          // Do nothing, just continue to next step.
        },
      );
      await _authService.setBMI(
        newBMI: double.parse(cBMI.value),
        onError: (String error) {
          _handleErrors(error, ref);
        },
        onSuccess: _handleSuccess,
      );
      ref.read(spinnerProvider.notifier).cancelSpinner();
    } else {
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }

  void _handleErrors(String error, WidgetRef ref) {
    // Log the error, cancel the spinner, pop the bottomsheet and show
    // a SnackBar to the user.
    Logger().e('Error: $error');
    ref.read(spinnerProvider.notifier).cancelSpinner();
    Navigator.pop(context);
    rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          'Error: $error',
          style: TextStyle(
            color: ref.watch(themeProvider.notifier).isDark
                ? flexSchemeDark.onError
                : flexSchemeLight.onError,
          ),
        ),
        showCloseIcon: true,
        backgroundColor: ref.watch(themeProvider.notifier).isDark
            ? flexSchemeDark.error
            : flexSchemeLight.error,
      ),
    );
  }

  void _handleSuccess() {
    // Log the success, cancel the spinner, pop the bottomsheet and show
    // a SnackBar to the user.
    Logger().i('BMI has been calculated and saved.');
    ref.read(spinnerProvider.notifier).cancelSpinner();
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
