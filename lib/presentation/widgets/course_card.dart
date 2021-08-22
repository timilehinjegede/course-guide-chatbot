import 'package:chatbot/data/models/course.dart';
import 'package:chatbot/utils/colors.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key key,
    this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isDismissible: true,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          builder: (context) {
            return Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20, 30, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    course.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Course Faculty',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    course.faculty,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                   SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        height: 130,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black.withOpacity(.15),
            ),
          ],
          color: Colors.white,
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Course: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: Text(
                    course.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  'Faculty: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: Text(
                    course.faculty,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  'Universities offering ${course.name}',
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 25,
                  color: lightColors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
