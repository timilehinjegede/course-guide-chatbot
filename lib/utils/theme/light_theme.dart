import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';

class LightTheme {
  const LightTheme._();
  static ThemeData appLightTheme = _buildAppTheme();

  static ThemeData _buildAppTheme() {
    final baseTheme = ThemeData.light();

    return baseTheme.copyWith(
      primaryColor: lightColors.primary,
      buttonColor: lightColors.primary,
      disabledColor: lightColors.grey,
      scaffoldBackgroundColor: lightColors.background,
      backgroundColor: lightColors.lightBackground,
      primaryColorLight: lightColors.primary,
      accentColor: lightColors.primary,
      indicatorColor: lightColors.primary,
      buttonTheme: baseTheme.buttonTheme.copyWith(
        buttonColor: lightColors.primary,
        disabledColor: lightColors.grey,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
        focusColor: lightColors.primary,
      ),
      floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
        backgroundColor: lightColors.primary,
        foregroundColor: lightColors.white,
      ),
      primaryIconTheme: baseTheme.primaryIconTheme.copyWith(
        color: lightColors.black,
      ),
      iconTheme: baseTheme.iconTheme.copyWith(
        color: lightColors.black,
      ),
      accentIconTheme: baseTheme.accentIconTheme.copyWith(
        color: lightColors.white,
      ),
      primaryTextTheme: _buildAppTextTheme(baseTheme.textTheme),
      accentTextTheme: _buildAppTextTheme(baseTheme.textTheme),
      textTheme: _buildAppTextTheme(baseTheme.textTheme),
    );
  }

  static TextTheme _buildAppTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline4: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          headline5: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          subtitle1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15,
          ),
          subtitle2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          button: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25,
          ),
          caption: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
          ),
          overline: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
          ),
        )
        .apply(
          fontFamily: Strings.fontFamily,
          bodyColor: lightColors.text,
        );
  }
}
