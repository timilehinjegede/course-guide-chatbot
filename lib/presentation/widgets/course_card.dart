import 'package:chatbot/data/models/course.dart';
import 'package:chatbot/presentation/widgets/course_details_widget.dart';
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
              height: MediaQuery.of(context).size.height * 0.8,
              padding: EdgeInsets.only(top: 20.0),
              child: CourseDetailsWidget(
                course: course,
              ),
            );
          },
        );
      },
      child: Container(
        height: 110,
        width: 320,
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
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: lightColors.primary.withOpacity(.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  course.name.split(' ').first[0] +
                      course.name.split(' ').last[0],
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: lightColors.text,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Faculty: ',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        course.faculty,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${course.universities.private.length + course.universities.federal.length + course.universities.state.length} universities offers this course',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
