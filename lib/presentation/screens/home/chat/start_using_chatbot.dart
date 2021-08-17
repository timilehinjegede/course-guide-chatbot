import 'package:chatbot/presentation/widgets/widgets.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';

class StartUsingChatbot extends StatelessWidget {
  const StartUsingChatbot({
    Key key,
    this.onStartUsingTapped,
  }) : super(key: key);

  final VoidCallback onStartUsingTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: lightColors.kOrange,
            ),
            child: Center(
              child: Text(
                '🤖',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
          YBox(15),
          Text(
            'You are all set!',
            style: TextStyle(
              fontSize: 24,
              color: lightColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          YBox(10),
          Text(
            'Remember you can always reach me by either sending a text or using voice',
            style: TextStyle(
              fontSize: 15,
              color: lightColors.subText,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          YBox(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    color: lightColors.primary.withOpacity(.3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: AppButton(
                title: 'Start Using Chatbot',
                onPressed: onStartUsingTapped,
                radius: 5,
                textColor: lightColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
