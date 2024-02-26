import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: always_specify_types
final obscuredProvider =
    NotifierProvider<ObscuredNotifier, bool>(ObscuredNotifier.new);

class ObscuredNotifier extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  Future<void> setObscured({required bool isObscured}) async {
    state = isObscured;
  }
}
