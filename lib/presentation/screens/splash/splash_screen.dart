import 'dart:async';

import 'package:chatbot/data/services/services.dart';
import 'package:chatbot/data/services/storage/storage_service.dart';
import 'package:chatbot/presentation/screens/auth/auth_screen.dart';
import 'package:chatbot/presentation/screens/get_started/get_started_screen.dart';
import 'package:chatbot/presentation/screens/home/home.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColors.primary,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 10,
                  color: lightColors.white.withOpacity(.4),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 5,
                    color: lightColors.white,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/chatbot.svg',
                      color: lightColors.white,
                      height: 65,
                      width: 65,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Apollo'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = lightColors.white
                          ..strokeCap = StrokeCap.round,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadSplash() {
    const kDuration = Duration(seconds: 4);
    StorageService storageService = StorageService();
    bool isLoggedIn = storageService.getUserState().isLoggedIn ?? false;
    bool hasOnboarded = storageService.getUserState().hasOnboarded ?? false;
    Timer(
      kDuration,
      () {
        if (hasOnboarded) {
          if (isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Home(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => AuthScreen(),
              ),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => GetStartedScreen(),
            ),
          );
        }
      },
    );
  }
}
