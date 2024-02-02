// This file is used to keep certain screens awake when the app is running.
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

void keepScreenAwake() {
  js.context.callMethod(
    'eval',
    <String>['navigator.wakeLock.request("screen")'],
  );
}
