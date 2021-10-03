import 'package:flutter/foundation.dart';

class Strings {
  const Strings._();

  static const String fontFamily = 'Roboto';
  static const String getStartedNow = 'Get Started Now';
  static const String next = 'Next';
  // 'Hello! 👋🏾, I\'m "Chatbot", your personal course guide assistant.',

  static const List<String> getStartedTitles = [
    'Get Qualified Courses.',
    'Check previous conversation.',
    'Access Anywhere, Anytime.',
  ];
  static const List<String> getStartedDescriptions = [
    'Have access to list of courses you can study based on the Olevel and UTME subjects you offered.',
    'Your previous conversations and queries are always available to access, view and verify.',
    'Query and make Inquries about the courses you can study in Nigerian institutions.',
  ];

  static const List<String> getOnboardingImages = [
    'assets/images/chatbot_4.svg',
    'assets/images/chatbot_5.svg',
    'assets/images/chatbot_1.svg',
  ];

  static const String signInWithGoogle = 'Sign in with Google';
  static const String signInWithFacebook = 'Log in with Facebook';
  static const String signInWithApple = 'Sign in with Apple';

  static const String defaultErrorMessage = 'Ooops! Something went wrong 😔.';

  // firebase keys
  static const String usersCollection = 'users';

  // static const String usersCollection =
  //     kDebugMode ? 'users_dev' : 'users_production';
      

  // hive keys
  static const String userBox = 'user';
  static const String userStateBox = 'user_state';

  static const String darkThemeMode = 'dark_theme_mode';
  static const String lightThemeMode = 'light_theme_mode';

  static const String googleLogin = 'google_login';
  static const String facebookLogin = 'facebook_login';
  static const String appleLogin = 'apple_login';
}
