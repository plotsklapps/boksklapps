// ignore_for_file: public_member_api_docs
import 'package:boksklapps/all_imports.dart';

/// String constants
class StringUtils {
  static const String kBoks = 'BOKS';
  static const String kKlapps = 'klapps';
  static const String kSparringPartner = '- Sparring Partner -';
  static const String kCreatedBy = 'Created by';
  static const String kSignIn = 'SIGN IN';
  static const String kSignUp = 'SIGN UP';
  static const String kResetPassword = 'RESET PASSWORD';
  static const String kLabelEmail = 'Emailaddress';
  static const String kLabelOldEmail = 'Old Emailaddress';
  static const String kLabelNewEmail = 'New Emailaddress';
  static const String kNewUserName = 'New Username';
  static const String kUserName = 'Username';
  static const String kLabelPassword = 'Password';
  static const String kLabelConfirmPassword = 'Confirm Password';
  static const String kCreateAccount = 'Create an Account';
  static const String kForgotPassword = 'Forgot Password';
  static const String kBackToLogin = 'Back to Login';
  static const String kHome = 'HOME';
  static const String kGet = 'GET';
  static const String kShit = 'SHIT';
  static const String kDone = 'DONE';
  static const String kStartBeastMode = 'Start Beast Mode';
  static const String kAccount = 'ACCOUNT';
  static const String kAbout = 'ABOUT';
  static const String kNoAccount = 'Sneak Peeker';
  static const String kSettings = 'SETTINGS';
  static const String kColorScheme = 'Color Scheme';
  static const String kLightSystemDark = 'Light / System / Dark';
  static const String kPunchSound = 'Punch Sound';
  static const String kEnterInfo = 'Please provide the following information';
  static const String kEmailAddressChanged =
      'Emailaddress changed, please login again...';
  static const String kUsernameChanged = 'Username updated...';
  static const String kTimers = 'TIMERS';
  static const String kPunches = 'PUNCHES';
  static const String kTempo = 'TEMPO';
  static const String kTotalTime = 'Total Time';
  static const String kSetTime = 'Set Time';
  static const String kRestTime = 'Rest Time';
  static const String kRearBodyHook = 'REAR BODY HOOK';
  static const String k4B = '4B';
  static const String kRearBodyHookPath = 'assets/PNG/punch_rearbodyhook.png';
  static const String kBodyCross = 'BODY CROSS';
  static const String k2B = '2B';
  static const String kBodyCrossPath = 'assets/PNG/punch_bodycross.png';
  static const String kBodyJab = 'BODY JAB';
  static const String k1B = '1B';
  static const String kBodyJabPath = 'assets/PNG/punch_bodyjab.png';
  static const String kLeadBodyHook = 'LEAD BODY HOOK';
  static const String k3B = '3B';
  static const String kLeadBodyHookPath = 'assets/PNG/punch_leadbodyhook.png';
  static const String kRearUppercut = 'REAR UPPERCUT';
  static const String k6 = '6';
  static const String kRearUppercutPath = 'assets/PNG/punch_rearuppercut.png';
  static const String kLeadUppercut = 'LEAD UPPERCUT';
  static const String k5 = '5';
  static const String kLeadUppercutPath = 'assets/PNG/punch_leaduppercut.png';
  static const String kRearHook = 'REAR HOOK';
  static const String k4 = '4';
  static const String kRearHookPath = 'assets/PNG/punch_rearhook.png';
  static const String kCross = 'CROSS';
  static const String k2 = '2';
  static const String kCrossPath = 'assets/PNG/punch_cross.png';
  static const String kJab = 'JAB';
  static const String k1 = '1';
  static const String kJabPath = 'assets/PNG/punch_jab.png';
  static const String kLeadHook = 'LEAD HOOK';
  static const String k3 = '3';
  static const String kLeadHookPath = 'assets/PNG/punch_leadhook.png';
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
  static const Icon kEmailAddress = Icon(Icons.email_outlined);
  static const Icon kPassword = Icon(Icons.lock_outlined);
  static const Icon kSettings = Icon(Icons.settings_outlined);
  static const Icon kLightMode = Icon(Icons.light_mode_outlined);
  static const Icon kSystemMode = Icon(Icons.phone_android_outlined);
  static const Icon kDarkMode = Icon(Icons.dark_mode_outlined);
  static const Icon kOuterSpace = Icon(Icons.rocket_launch_outlined);
  static const Icon kGreenMoney = Icon(Icons.payments_outlined);
  static const Icon kRedWine = Icon(Icons.wine_bar_outlined);
  static const Icon kWoman = Icon(Icons.female_outlined);
  static const Icon kMan = Icon(Icons.male_outlined);
  static const Icon kDTMF = Icon(Icons.dialpad_outlined);
  static const Icon kAccount = Icon(Icons.person_outlined);
  static const Icon kLogout = Icon(Icons.logout_outlined);
  static const Icon kRemove = Icon(Icons.remove_outlined);
  static const Icon kAdd = Icon(Icons.add_outlined);
  static const Icon kHome = Icon(Icons.home_outlined);
  static const Icon kBoxing = Icon(Icons.sports_mma_outlined);
}

// Height / Width constants
class SizeUtils {
  static const double kPunchButtonHeight = 100.0;
  static const double kPunchButtonWidth = 75.0;
}

// Punch sounds
class SoundUtils {
  //DTMF sounds
  static const String kPunch1DTMF = 'MP3/DTMF/dtmf-1.mp3';
  static const String kPunch2DTMF = 'MP3/DTMF/dtmf-2.mp3';
  static const String kPunch3DTMF = 'MP3/DTMF/dtmf-3.mp3';
  static const String kPunch4DTMF = 'MP3/DTMF/dtmf-4.mp3';
  static const String kPunch5DTMF = 'MP3/DTMF/dtmf-5.mp3';
  static const String kPunch6DTMF = 'MP3/DTMF/dtmf-6.mp3';
  static const String kPunch1BDTMF = 'MP3/DTMF/dtmf-7.mp3';
  static const String kPunch2BDTMF = 'MP3/DTMF/dtmf-8.mp3';
  static const String kPunch3BDTMF = 'MP3/DTMF/dtmf-9.mp3';
  static const String kPunch4BDTMF = 'MP3/DTMF/dtmf-0.mp3';

  // Elli voice
  static const String kNameElli = 'assets/MP3/Elli/name_Elli.mp3';
  static const String kPunch1Elli = 'assets/MP3/Elli/punch_1_Elli.mp3';
  static const String kPunch2Elli = 'assets/MP3/Elli/punch_2_Elli.mp3';
  static const String kPunch3Elli = 'assets/MP3/Elli/punch_3_Elli.mp3';
  static const String kPunch4Elli = 'assets/MP3/Elli/punch_4_Elli.mp3';
  static const String kPunch5Elli = 'assets/MP3/Elli/punch_5_Elli.mp3';
  static const String kPunch6Elli = 'assets/MP3/Elli/punch_6_Elli.mp3';
  static const String kPunch1BElli = 'assets/MP3/Elli/punch_1B_Elli.mp3';
  static const String kPunch2BElli = 'assets/MP3/Elli/punch_2B_Elli.mp3';
  static const String kPunch3BElli = 'assets/MP3/Elli/punch_3B_Elli.mp3';
  static const String kPunch4BElli = 'assets/MP3/Elli/punch_4B_Elli.mp3';
  static const String kGoodJobElli = 'assets/MP3/Elli/goodjob_Elli.mp3';
  static const String kKeepItUpElli = 'assets/MP3/Elli/keepitup_Elli.mp3';
  static const String kPrepareForTheNextSetElli =
      'assets/MP3/Elli/prepareforthenextset_Elli.mp3';
  static const String kRestElli = 'assets/MP3/Elli/rest_Elli.mp3';
  static const String kPunchJabElli = 'assets/MP3/Elli/punch_jab_Elli.mp3';
  static const String kPunchCrossElli = 'assets/MP3/Elli/punch_cross_Elli.mp3';
  static const String kPunchLeadHookElli =
      'assets/MP3/Elli/punch_lead_hook_Elli.mp3';
  static const String kPunchRearHookElli =
      'assets/MP3/Elli/punch_rear_hook_Elli.mp3';
  static const String kPunchLeadUppercutElli =
      'assets/MP3/Elli/punch_lead_uppercut_Elli.mp3';
  static const String kPunchRearUppercutElli =
      'assets/MP3/Elli/punch_rear_uppercut_Elli.mp3';
  static const String kPunchBodyJabElli =
      'assets/MP3/Elli/punch_body_jab_Elli.mp3';
  static const String kPunchBodyCrossElli =
      'assets/MP3/Elli/punch_body_cross_Elli.mp3';
  static const String kPunchLeadBodyHookElli =
      'assets/MP3/Elli/punch_lead_body_hook_Elli.mp3';
  static const String kPunchRearBodyHookElli =
      'assets/MP3/Elli/punch_rear_body_hook_Elli.mp3';

  // Arnold voice
  static const String kNameArnold = 'assets/MP3/Arnold/name_Arnold.mp3';
  static const String kPunch1Arnold = 'assets/MP3/Arnold/punch_1_Arnold.mp3';
  static const String kPunch2Arnold = 'assets/MP3/Arnold/punch_2_Arnold.mp3';
  static const String kPunch3Arnold = 'assets/MP3/Arnold/punch_3_Arnold.mp3';
  static const String kPunch4Arnold = 'assets/MP3/Arnold/punch_4_Arnold.mp3';
  static const String kPunch5Arnold = 'assets/MP3/Arnold/punch_5_Arnold.mp3';
  static const String kPunch6Arnold = 'assets/MP3/Arnold/punch_6_Arnold.mp3';
  static const String kPunch1BArnold = 'assets/MP3/Arnold/punch_1B_Arnold.mp3';
  static const String kPunch2BArnold = 'assets/MP3/Arnold/punch_2B_Arnold.mp3';
  static const String kPunch3BArnold = 'assets/MP3/Arnold/punch_3B_Arnold.mp3';
  static const String kPunch4BArnold = 'assets/MP3/Arnold/punch_4B_Arnold.mp3';
  static const String kGoodJobArnold = 'assets/MP3/Arnold/goodjob_Arnold.mp3';
  static const String kKeepItUpArnold = 'assets/MP3/Arnold/keepitup_Arnold.mp3';
  static const String kPrepareForTheNextSetArnold =
      'assets/MP3/Arnold/prepareforthenextset_Arnold.mp3';
  static const String kRestArnold = 'assets/MP3/Arnold/rest_Arnold.mp3';
  static const String kPunchJabArnold =
      'assets/MP3/Arnold/punch_jab_Arnold.mp3';
  static const String kPunchCrossArnold =
      'assets/MP3/Arnold/punch_cross_Arnold.mp3';
  static const String kPunchLeadHookArnold =
      'assets/MP3/Arnold/punch_lead_hook_Arnold.mp3';
  static const String kPunchRearHookArnold =
      'assets/MP3/Arnold/punch_rear_hook_Arnold.mp3';
  static const String kPunchLeadUppercutArnold =
      'assets/MP3/Arnold/punch_lead_uppercut_Arnold.mp3';
  static const String kPunchRearUppercutArnold =
      'assets/MP3/Arnold/punch_rear_uppercut_Arnold.mp3';
  static const String kPunchBodyJabArnold =
      'assets/MP3/Arnold/punch_body_jab_Arnold.mp3';
  static const String kPunchBodyCrossArnold =
      'assets/MP3/Arnold/punch_body_cross_Arnold.mp3';
  static const String kPunchLeadBodyHookArnold =
      'assets/MP3/Arnold/punch_lead_body_hook_Arnold.mp3';
  static const String kPunchRearBodyHookArnold =
      'assets/MP3/Arnold/punch_rear_body_hook_Arnold.mp3';

  // Boxing sounds
  static const String kOneBell = 'assets/MP3/Sound/boxing_bell_one.mp3';
  static const String kThreeBell = 'assets/MP3/Sound/boxing_bell_three.mp3';
  static const String kBoxingIntroMusic =
      'assets/MP3/Sound/boxing_wii_music.mp3';
  static const String kGameboySound = 'assets/MP3/Sound/gameboy_sound.mp3';
}
