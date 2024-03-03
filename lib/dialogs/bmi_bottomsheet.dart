import 'package:boksklapps/custom_snackbars.dart';
import 'package:boksklapps/providers/age_provider.dart';
import 'package:boksklapps/providers/bmi_provider.dart';
import 'package:boksklapps/providers/height_provider.dart';
import 'package:boksklapps/providers/spinner_provider.dart';
import 'package:boksklapps/providers/weight_provider.dart';
import 'package:boksklapps/theme/bottomsheet_padding.dart';
import 'package:boksklapps/theme/text_utils.dart';
import 'package:boksklapps/widgets/bottomsheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

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
                  AgeTextFormField(ref: ref)
                      .animate()
                      .fade()
                      .moveX(delay: 200.ms, begin: -32),
                  const SizedBox(height: 8),
                  HeightTextFormField(ref: ref)
                      .animate()
                      .fade(delay: 200.ms)
                      .moveX(delay: 400.ms, begin: -32),
                  const SizedBox(height: 8),
                  WeightTextFormField(ref: ref)
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
                  ref.watch(bmiProvider).toStringAsFixed(1),
                  style: TextUtils.fontXL,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Cancel the spinner.
                    ref.read(spinnerProvider.notifier).cancelSpinner();
                    // Pop the bottomsheet.
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
    // Start the spinner.
    ref.read(spinnerProvider.notifier).startSpinner();

    // Validate the form and save the values.
    final FormState? bmiForm = _bmiFormKey.currentState;
    if (bmiForm!.validate()) {
      bmiForm.save();

      try {
        // Calculate the BMI.
        await ref.read(bmiProvider.notifier).setBMI();

        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Pop the bottomsheet.
        if (mounted) {
          Navigator.pop(context);
        }

        // Show a SnackBar.
        CustomSnackBars.showSuccess(
          ref,
          'Successfully calculated and saved your BMI: '
          '${ref.watch(bmiProvider).toStringAsFixed(1)}!',
        );
      } catch (error) {
        // Log the error.
        Logger().e(error);

        // Cancel the spinner.
        ref.read(spinnerProvider.notifier).cancelSpinner();

        // Pop the bottomsheet.
        if (mounted) {
          Navigator.pop(context);
        }

        // Show a SnackBar.
        CustomSnackBars.showError(ref, error.toString());
      }
    } else {
      // Cancel the spinner.
      ref.read(spinnerProvider.notifier).cancelSpinner();
    }
  }
}

class AgeTextFormField extends StatelessWidget {
  const AgeTextFormField({
    required this.ref,
    super.key,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid age.';
        }
        return null;
      },
      onSaved: (String? value) {
        ref.read(ageProvider.notifier).setAge(int.parse(value!));
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        icon: SizedBox(
          width: 24,
          child: FaIcon(FontAwesomeIcons.cakeCandles),
        ),
        label: Text('Age in years'),
      ),
    );
  }
}

class HeightTextFormField extends StatelessWidget {
  const HeightTextFormField({
    required this.ref,
    super.key,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid height.';
        }
        return null;
      },
      onSaved: (String? value) {
        ref.read(heightProvider.notifier).setHeight(int.parse(value!));
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        icon: SizedBox(
          width: 24,
          child: FaIcon(FontAwesomeIcons.rulerVertical),
        ),
        label: Text('Height in centimeters'),
      ),
    );
  }
}

class WeightTextFormField extends StatelessWidget {
  const WeightTextFormField({
    required this.ref,
    super.key,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid weight.';
        }
        return null;
      },
      onSaved: (String? value) {
        ref.read(weightProvider.notifier).setWeight(int.parse(value!));
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        icon: SizedBox(
          width: 24,
          child: FaIcon(FontAwesomeIcons.weightHanging),
        ),
        label: Text('Weight in kilograms'),
      ),
    );
  }
}
