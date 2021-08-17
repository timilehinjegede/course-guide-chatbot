import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          YBox(40),
          CircleAvatar(
            radius: 60,
          ),
          YBox(50),
          TextField(
            controller: TextEditingController(
              text: 'jegedetimilehin2001@gmail.com',
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
              text: 'Jegede',
            ),
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
              text: 'Timilehin',
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
              text: '08143037721',
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
    );
  }
}
