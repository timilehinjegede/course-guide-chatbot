import 'package:flutter/material.dart';

class CustomChatPainter extends CustomPainter {
  CustomChatPainter(
    this.color,
  );

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
