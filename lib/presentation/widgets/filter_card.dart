import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';

class FilterCard extends StatelessWidget {
  const FilterCard({
    Key key,
    this.label,
    this.onTap,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: lightColors.primary,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: lightColors.primary.withOpacity(.3),
              blurRadius: 20,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: lightColors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
