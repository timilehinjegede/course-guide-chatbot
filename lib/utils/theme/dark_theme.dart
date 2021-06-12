import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';

class DarkTheme {
  const DarkTheme._();
  static ThemeData appDarkTheme = _buildAppTheme();

  static ThemeData _buildAppTheme() {
    final baseTheme = ThemeData.dark();

    return baseTheme.copyWith(
      primaryColor: darkColors.primary,
      buttonColor: darkColors.primary,
      disabledColor: darkColors.grey,
      scaffoldBackgroundColor: darkColors.background,
      backgroundColor: darkColors.lightBackground,
      primaryColorLight: darkColors.primary,
      accentColor: darkColors.primary,
      indicatorColor: darkColors.primary,
      buttonTheme: baseTheme.buttonTheme.copyWith(
        buttonColor: darkColors.primary,
        disabledColor: darkColors.grey,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
        focusColor: darkColors.primary,
      ),
      floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
        backgroundColor: darkColors.primary,
        foregroundColor: darkColors.white,
      ),
      primaryIconTheme: baseTheme.primaryIconTheme.copyWith(
        color: darkColors.black,
      ),
      iconTheme: baseTheme.iconTheme.copyWith(
        color: darkColors.black,
      ),
      accentIconTheme: baseTheme.accentIconTheme.copyWith(
        color: darkColors.white,
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
          bodyColor: darkColors.text,
        );
  }
}
