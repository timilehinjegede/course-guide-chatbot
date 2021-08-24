import 'package:chatbot/data/services/storage/storage_service.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = StorageService().getUser();
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
              'PROFILE'.toUpperCase(),
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
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lightColors.primary,
                    image: DecorationImage(
                      image: NetworkImage(
                        user.photoUrl,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                YBox(50),
                TextField(
                  controller:
                      TextEditingController(text: user.firstName ?? 'N/A'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'First Name',
                  ),
                  readOnly: true,
                ),
                YBox(25),
                TextField(
                  controller: TextEditingController(
                    text: user.lastName ?? 'N/A',
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Last Name',
                  ),
                  readOnly: true,
                ),
                YBox(25),
                TextField(
                  controller: TextEditingController(
                    text: user.email ?? 'N/A',
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Email Address',
                  ),
                  readOnly: true,
                ),
                YBox(25),
                TextField(
                  controller: TextEditingController(
                    text: user.phoneNumber ?? 'N/A',
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Phone Number',
                  ),
                  readOnly: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
