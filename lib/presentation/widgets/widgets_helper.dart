import 'package:chatbot/utils/colors.dart';
import 'package:chatbot/utils/dims.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetsHelper {
  WidgetsHelper._();

  // loading dialog
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 150,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  // duplication
  static void showErrorDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightColors.fail,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close_rounded,
                        color: lightColors.white,
                      ),
                    ),
                  ),
                  YBox(10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: lightColors.text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // duplication
  static void showSuccessDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightColors.success,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: lightColors.white,
                      ),
                    ),
                  ),
                  YBox(10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: lightColors.text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
