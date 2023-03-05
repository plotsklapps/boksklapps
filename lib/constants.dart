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
  static const Icon kForward = Icon(Icons.arrow_forward_outlined);
  static const Icon kEmailAddress = Icon(Icons.email_outlined);
  static const Icon kPassword = Icon(Icons.lock_outlined);
  static const Icon kSettings = Icon(Icons.settings_outlined);
  static const Icon kLightMode = Icon(Icons.light_mode_outlined);
  static const Icon kSystemMode = Icon(Icons.phone_android_outlined);
  static const Icon kDarkMode = Icon(Icons.dark_mode_outlined);
  static const Icon kOuterSpace = Icon(Icons.rocket_launch_outlined);
  static const Icon kGreenMoney = Icon(Icons.payments_outlined);
  static const Icon kRedWine = Icon(Icons.wine_bar_outlined);
  static const Icon kWoman = Icon(Icons.woman_outlined);
  static const Icon kMan = Icon(Icons.man_outlined);
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
  static const String kPunch1DTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-1.mp3?'
      'alt=media&token=e5322d36-2d53-4c62-87c4-56018a62cdcf';
  static const String kPunch2DTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-2.mp3?'
      'alt=media&token=bebd18cc-594b-41fc-92d9-2dd613de6f9c';
  static const String kPunch3DTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-3.mp3?'
      'alt=media&token=1da7cd79-8399-4244-b0dc-74117ef231a7';
  static const String kPunch4DTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-4.mp3?'
      'alt=media&token=0eda42f0-c308-494f-b76c-5a0eeb1c03d1';
  static const String kPunch5DTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-5.mp3?'
      'alt=media&token=b022e30e-c4b4-40ca-9ddd-6144cb9814d5';
  static const String kPunch6DTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-6.mp3?'
      'alt=media&token=a2c35291-9749-4a10-8e94-ae0f20116d7f';
  static const String kPunch1BDTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-7.mp3?'
      'alt=media&token=56ef2438-4ddb-405a-87e4-180cdb1486b2';
  static const String kPunch2BDTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-8.mp3?'
      'alt=media&token=6f896b08-7893-44d0-b746-08c7274aab35';
  static const String kPunch3BDTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-9.mp3?'
      'alt=media&token=e7f85cd4-c6f7-4db5-9944-46d412317bc3';
  static const String kPunch4BDTMF =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-DTMF%2Fdtmf-0.mp3?'
      'alt=media&token=aab76f8c-baaf-48df-a18b-8838cc50ef92';
  // Ellie voice
  static const String kPunch1Ellie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_1_Ellie.mp3?'
      'alt=media&token=b20861b2-81a8-48b7-92f6-a228acb34ab1';
  static const String kPunch2Ellie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_2_Ellie.mp3?'
      'alt=media&token=bbe6452b-2234-452b-a227-fa0bfdb5cf02';
  static const String kPunch3Ellie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_3_Ellie.mp3?'
      'alt=media&token=258fd7ac-f2d0-44c4-b990-93ee7c8dc025';
  static const String kPunch4Ellie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_4_Ellie.mp3?'
      'alt=media&token=31a2de7c-4887-4e1a-9728-4adde4576231';
  static const String kPunch5Ellie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_5_Ellie.mp3?'
      'alt=media&token=6cdb0804-1da5-47ca-a6fd-adfbc3d64b5c';
  static const String kPunch6Ellie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_6_Ellie.mp3?'
      'alt=media&token=52c11463-1956-4035-98bc-11b4ce173a74';
  static const String kPunch1BEllie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_1B_Ellie.mp3?'
      'alt=media&token=dc12d4f8-062f-484b-8a14-9d3a8a95e8fb';
  static const String kPunch2BEllie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_2B_Ellie.mp3?'
      'alt=media&token=68b66e84-a8d5-4cef-94da-67739fe30a23';
  static const String kPunch3BEllie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_3B_Ellie.mp3?'
      'alt=media&token=ada2eb0f-705e-4820-98ab-44fa6bd46d49';
  static const String kPunch4BEllie =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Ellie%2Fpunch_4B_Ellie.mp3?'
      'alt=media&token=3b202b84-647e-49d3-92c7-89b719fcd283';
  // Arnold voice
  static const String kPunch1Arnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_1_Arnold.mp3?'
      'alt=media&token=06793af1-9a8e-4be0-8f0d-85f00eece74e';
  static const String kPunch2Arnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_2_Arnold.mp3?'
      'alt=media&token=99a45539-7a87-4ca0-aa5b-2181c68b2eb1';
  static const String kPunch3Arnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_3_Arnold.mp3?'
      'alt=media&token=87c295a5-7f0c-4766-985d-421902e5ca3c';
  static const String kPunch4Arnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_4_Arnold.mp3?'
      'alt=media&token=5da9044c-50ec-4d1d-a14f-30040fb627ee';
  static const String kPunch5Arnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_5_Arnold.mp3?'
      'alt=media&token=fffaaeac-efb2-4e56-8257-12883a0e1a93';
  static const String kPunch6Arnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_6_Arnold.mp3?'
      'alt=media&token=b047c8ad-5aec-4040-a895-a439cf3f4fcc';
  static const String kPunch1BArnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_1B_Arnold.mp3?'
      'alt=media&token=0317a6a0-9322-4e87-a593-e6c1f506b9f0';
  static const String kPunch2BArnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_2B_Arnold.mp3?'
      'alt=media&token=116af52e-82f1-44fa-9f58-4e9d28407ca6';
  static const String kPunch3BArnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_3B_Arnold.mp3?'
      'alt=media&token=728cba82-e39f-49d9-83d2-26ed0de70d13';
  static const String kPunch4BArnold =
      'https://firebasestorage.googleapis.com/v0/b/'
      'boksklapps.appspot.com/o/MP3-Arnold%2Fpunch_4B_Arnold.mp3?'
      'alt=media&token=98342a2f-26cd-4f86-a965-c219b186b32a';
}
