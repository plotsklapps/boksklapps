// ignore_for_file: public_member_api_docs
import 'package:boksklapps/all_imports.dart';

/// String constants
class StringUtils {
  static const String kBoks = 'BOKS';
  static const String kKlapps = 'klapps';
  static const String kSparringPartner = '- Sparring Partner -';
  static const String kCreatedBy = 'Created by plotsklapps';
  static const String kLabelEmail = 'Emailaddress';
  static const String kLabelPassword = 'Password';
  static const String kCreateAccount = 'Create an Account';
  static const String kForgotPassword = 'Forgot Password';
  static const String kBackToLogin = 'Back to Login';
  static const String kGet = 'GET';
  static const String kShit = 'SHIT';
  static const String kDone = 'DONE';
}

/// TextStyle constants
class TextStyleUtils {
  static const TextStyle kLogo1 = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle kLogo2 = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle kHeadline1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle kHeadline2 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle kHeadline3 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w200,
  );
  static const TextStyle kBodyText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w200,
  );
}

/// Icon constants
class IconUtils {
  static const Icon kForward = Icon(Icons.arrow_forward_outlined);
  static const Icon kEmailAddress = Icon(Icons.email_outlined);
  static const Icon kPassword = Icon(Icons.lock_outlined);
  static const Icon kSettings = Icon(Icons.settings_outlined);
  static const Icon kAccount = Icon(Icons.person_outlined);
  static const Icon kLogout = Icon(Icons.logout_outlined);
  static const Icon kRemove = Icon(Icons.remove_outlined);
  static const Icon kAdd = Icon(Icons.add_outlined);
}
