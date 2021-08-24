import 'package:chatbot/data/models/course.dart';
import 'package:chatbot/utils/colors.dart';
import 'package:flutter/material.dart';

class CourseDetailsWidget extends StatelessWidget {
  const CourseDetailsWidget({
    Key key,
    this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
              height: 20,
            ),
            Text(
              'Universities offering the course:',
              style: TextStyle(
                fontSize: 18,
                color: lightColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
            _UniversitiesEntry(
              label: 'Private Universities',
              universities: [...course.universities.private],
            ),
            _UniversitiesEntry(
              label: 'Federal Universities',
              universities: [...course.universities.federal],
            ),
            _UniversitiesEntry(
              label: 'State Universities',
              universities: [...course.universities.state],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _UniversitiesEntry extends StatelessWidget {
  const _UniversitiesEntry({
    Key key,
    this.universities,
    this.label,
  }) : super(key: key);

  final List<String> universities;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        label,
      ),
      children: [
        if (universities.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              'No universities offering this course',
            ),
          ),
        if (universities.isNotEmpty)
          ...List.generate(
            universities.length,
            (index) => ListTile(
              title: Text(
                (index + 1).toString() + '. ' + universities[index],
              ),
            ),
          ),
      ],
    );
  }
}
