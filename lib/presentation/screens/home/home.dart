import 'dart:developer';

import 'package:chatbot/data/services/courses/courses_service.dart';
import 'package:chatbot/presentation/screens/home/chat/chat_screen.dart';
import 'package:chatbot/presentation/screens/home/explore/explore_screen.dart';
import 'package:chatbot/presentation/screens/home/profile/profile_screen.dart';
import 'package:chatbot/presentation/screens/home/settings/settings_screen.dart';
import 'package:chatbot/presentation/widgets/widgets.dart';
import 'package:chatbot/utils/colors.dart';
import 'package:chatbot/utils/dims.dart';
import 'package:flutter/material.dart';

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
    ChatScreen(),
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
      appBar: _currentIndex == 0 || _currentIndex == 2
          ? AppBar(
              title: Text(
                _currentIndex == 0 ? 'Profile' : 'Settings',
              ),
              leading: InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                  _pageController.jumpToPage(_currentIndex);
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                ),
              ),
              centerTitle: false,
            )
          : AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chatbot Name',
                  ),
                  YBox(3),
                  Row(
                    children: [
                      Container(
                        height: 7,
                        width: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightColors.success,
                        ),
                      ),
                      XBox(5),
                      Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 13,
                          color: lightColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: lightColors.white,
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) async {
          CoursesService co = CoursesService();
          await co.getQualifiedCourses([]);
          setState(() {
            _currentIndex = newIndex;
          });
          _pageController.jumpToPage(_currentIndex);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_rounded,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_rounded,
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ..._bodyWidgets,
        ],
      ),
    );
  }
}
