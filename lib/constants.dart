// ignore_for_file: public_member_api_docs
import 'package:boksklapps/all_imports.dart';

/// String constants
class StringUtils {
  static const String kBoks = 'BOKS';
  static const String kKlapps = 'klapps';
  static const String kSparringPartner = '- Sparring Partner -';
  static const String kCreatedBy = 'Created by plotsklapps';
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
  static const Icon kForward = Icon(Icons.arrow_forward_ios_outlined);
  static const IconData kSettings = Icons.settings_outlined;
  static const IconData kAccount = Icons.person_outlined;
  static const IconData kLogout = Icons.logout_outlined;
}
