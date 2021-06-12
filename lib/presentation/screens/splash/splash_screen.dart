import 'dart:async';

import 'package:chatbot/data/services/services.dart';
import 'package:chatbot/data/services/storage/storage_service.dart';
import 'package:chatbot/presentation/screens/auth/auth_screen.dart';
import 'package:chatbot/presentation/screens/get_started/get_started_screen.dart';
import 'package:chatbot/presentation/screens/home/home.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';

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
            SizedBox(
              height: 70,
              width: 70,
              child: Placeholder(),
            ),
            YBox(10),
            Text(
              'Chatbot Name',
              style: TextStyle(
                color: lightColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadSplash() {
    const kDuration = Duration(seconds: 2);
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
