import 'dart:developer';

import 'package:chatbot/data/services/courses/courses_service.dart';
import 'package:chatbot/presentation/screens/home/chat/chat_screen.dart';
import 'package:chatbot/presentation/screens/home/explore/explore_screen.dart';
import 'package:chatbot/presentation/screens/home/profile/profile_screen.dart';
import 'package:chatbot/presentation/screens/home/settings/settings_screen.dart';
import 'package:chatbot/presentation/widgets/key_alive_widget.dart';
import 'package:chatbot/presentation/widgets/widgets.dart';
import 'package:chatbot/utils/colors.dart';
import 'package:chatbot/utils/dims.dart';
import 'package:chatbot/utils/utils_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  PageController _pageController;

  final List<Widget> _bodyWidgets = [
    // ExploreScreen(),
    ProfileScreen(),
    KeepAliveWidget(
      child: ChatScreen(),
    ),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColors.primary,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) async {
          setState(() {
            _currentIndex = newIndex;
          });
          _pageController.jumpToPage(_currentIndex);
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile.svg',
              height: 30,
              width: 30,
              color:
                  _currentIndex == 0 ? lightColors.primary : lightColors.text,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/chat.svg',
              height: 30,
              width: 30,
              color:
                  _currentIndex == 1 ? lightColors.primary : lightColors.text,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/settings.svg',
              height: 30,
              width: 30,
              color:
                  _currentIndex == 2 ? lightColors.primary : lightColors.text,
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ..._bodyWidgets,
          ],
        ),
      ),
    );
  }
}
