import 'package:chatbot/data/models/course.dart';
import 'package:chatbot/data/models/models.dart';
import 'package:chatbot/data/services/storage/storage_service.dart';
import 'package:chatbot/presentation/screens/auth/auth_screen.dart';
import 'package:chatbot/presentation/screens/institutions/explore_institutions_screen.dart';
import 'package:chatbot/presentation/widgets/course_card.dart';
import 'package:chatbot/presentation/widgets/filter_card.dart';
import 'package:chatbot/presentation/widgets/widgets.dart';
import 'package:chatbot/utils/colors.dart';
import 'package:chatbot/utils/dims.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'SETTINGS'.toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = lightColors.white
                  ..strokeCap = StrokeCap.round,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: lightColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              children: [
                _ItemEntry(
                  label: 'Explore Institutions',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExploreInstitutionsScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
                _ItemEntry(
                  label: 'Rate App',
                  onTap: () {},
                ),
                Divider(),
                _ItemEntry(
                  label: 'Share',
                  onTap: () {},
                ),
                Divider(),
                YBox(50),
                SizedBox(
                  height: 60,
                  child: AppButton(
                    title: 'Logout',
                    onPressed: () {
                      StorageService().removeUser();
                      UserState userState = StorageService().getUserState();
                      userState = userState.copyWith(
                        isLoggedIn: false,
                      );
                      StorageService().saveUserState(userState: userState);
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AuthScreen(),
                        ),
                      );
                    },
                    textColor: lightColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemEntry extends StatelessWidget {
  const _ItemEntry({
    Key key,
    this.label,
    this.onTap,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
      ),
    );
  }
}
