import 'package:flutter/material.dart';

class ThemeModel {
  final Color primary;
  final Color lightBackground;
  final Color background;
  final Color text;
  final Color subText;
  final Color grey;
  final Color white;
  final Color black;
  final Color transparent;
  // others
  final Color kBlue;
  final Color kOrange;
  final Color kGreen;
  final Color kPink;

  const ThemeModel({
    this.primary,
    this.lightBackground,
    this.background,
    this.text,
    this.subText,
    this.grey = const Color(0xFFF6F7F8),
    this.white = const Color(0xFFFFFFFF),
    this.black = const Color(0xFF000000),
    this.transparent = Colors.transparent,
    // others
    this.kBlue = const Color(0xFF547ADE),
    this.kOrange = const Color(0xFFEA7B4F),
    this.kGreen = const Color(0xFF5BD358),
    this.kPink = const Color(0xFFE95087),
  });
  // others
}
