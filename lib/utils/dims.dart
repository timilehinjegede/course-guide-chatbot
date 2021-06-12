import 'package:flutter/material.dart';

extension DimsExtension on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;
  double deviceWidth([double extent = 1]) => mediaQuerySize.width * extent;
  double deviceHeight([double extent = 1]) => mediaQuerySize.height * extent;
  Orientation get deviceOrientation => MediaQuery.of(this).orientation;
  bool get isLandscape => deviceOrientation == Orientation.landscape;
  bool get isPortrait => deviceOrientation == Orientation.portrait;
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  // status bar height
  // bottom bar height
  // mobile
  bool get isMobile => mediaQuerySize.shortestSide < 600;
  // tablet
  bool get isTablet => mediaQuerySize.shortestSide >= 600;
  // desktop
  bool get isDeskTop => mediaQuerySize.shortestSide >= 1300;
}

class XBox extends StatelessWidget {
  final double _width;

  XBox(this._width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
    );
  }
}

class YBox extends StatelessWidget {
  final double _height;

  YBox(this._height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
    );
  }
}
