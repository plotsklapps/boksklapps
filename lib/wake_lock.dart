import 'dart:js' as js;

void keepScreenAwake() {
  js.context.callMethod(
    'eval',
    <String>['navigator.wakeLock.request("screen")'],
  );
}
