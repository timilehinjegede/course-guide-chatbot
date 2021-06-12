import 'package:flutter/foundation.dart';

class Strings {
  const Strings._();

  static const String fontFamily = 'Roboto';
  static const String getStartedNow = 'Get Started Now';
  static const String next = 'Next';
  static const List<String> getStartedTitles = [
    'Hello! 👋🏾, I\'m "Chatbot", your personal course guide assistant.',
    'Hello! 👋🏾, I\'m "Chatbot", your own very own course guide bot.',
    'Hello! 👋🏾, I\'m "Chatbot", your own very own course guide bot.',
  ];
  static const List<String> getStartedDescriptions = [
    '"Chatbot" will help you to manage yout personal goals and discover your personality.',
    'Are you currently searching for courses? You can ask me anything about it and I\'ll get it for you.',
    '"Chatbot" will help you to manage yout personal goals and discover your personality.',
  ];

  static const String signInWithGoogle = 'Sign in with Google';
  static const String signInWithFacebook = 'Sign in with Facebook';
  static const String signInWithApple = 'Sign in with Apple';

  static const String defaultErrorMessage = 'Ooops! Something went wrong 😔.';

  // firebase keys
  static const String usersCollection = kDebugMode ? 'users_dev' : 'users_production';

  // hive keys
  static const String userBox = 'user';
  static const String userStateBox = 'user_state';

  static const String darkThemeMode = 'dark_theme_mode';
  static const String lightThemeMode = 'light_theme_mode';

  static const String googleLogin = 'google_login';
  static const String facebookLogin = 'facebook_login';
  static const String appleLogin = 'apple_login';
}
