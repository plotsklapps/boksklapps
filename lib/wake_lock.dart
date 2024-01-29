// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

void keepScreenAwake() {
  js.context.callMethod(
    'eval',
    <String>['navigator.wakeLock.request("screen")'],
  );
}
