import 'package:chatbot/utils/colors.dart';
import 'package:chatbot/utils/dims.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key key,
    @required this.title,
    this.onPressed,
    this.color,
    this.textColor,
    this.radius = 8.0,
    this.height,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double radius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      minWidth: context.deviceWidth(),
      height: 55,
      color: color ?? lightColors.primary,
      textColor: textColor ?? lightColors.text,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: Text(
        title,
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key key,
    @required this.title,
    this.onPressed,
    this.color,
    this.textColor,
    this.radius = 50.0,
    this.height,
    @required this.imgSrc,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double radius;
  final double height;
  final String imgSrc;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      minWidth: context.deviceWidth(),
      height: 65,
      color: color ?? lightColors.primary,
      textColor: textColor ?? lightColors.text,
      disabledColor: lightColors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: lightColors.grey,
            ),
          ),
          XBox(10),
          Text(
            title,
          ),
        ],
      ),
    );
  }
}
