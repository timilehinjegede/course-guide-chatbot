import 'package:chatbot/presentation/widgets/widgets.dart';
import 'package:chatbot/utils/colors.dart';
import 'package:chatbot/utils/dims.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Explore institutions',
            ),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text(
              'Rate App',
            ),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text(
              'Help',
            ),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text(
              'Contact Support',
            ),
            onTap: () {},
          ),
          YBox(50),
          AppButton(
            title: 'Logout',
            onPressed: () {},
            textColor: lightColors.white,
          ),
        ],
      ),
    );
  }
}
