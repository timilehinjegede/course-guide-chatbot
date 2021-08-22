import 'dart:developer';

import 'package:chatbot/data/models/course.dart';
import 'package:chatbot/data/models/responses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialogflow_grpc/generated/google/protobuf/type.pb.dart';

class CoursesService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Course>> getQualifiedCourses(
      List<FieldParameter> fieldParameters) async {
    List<Course> qualifiedCourses = [];
    List<Course> coursesFromFirebase = [];
    int requiredCount = 0;
    int otherCount = 0;

    try {
      DocumentSnapshot documentSnapshot =
          await firebaseFirestore.collection('courses').doc('sciences').get();

      if (documentSnapshot.exists) {
        Map course = documentSnapshot.data();
        for (Map department in course['departments']) {
          coursesFromFirebase.add(Course.fromJson(department));
        }
        List<SubjectAndGrade> subjectsOffered =
            getCourseAndGradeFromFieldParamaters(fieldParameters);

        for (Course course in coursesFromFirebase) {
          requiredCount = 0;
          otherCount = 0;
          
          List<UtmeRequirement> requiredRequirements = course.utmeRequirements
              .where((element) => element.isRequired == true)
              .toList();
          List<UtmeRequirement> otherRequirements = course.utmeRequirements
              .where((element) => element.isRequired == false)
              .toList();

          log('course name is ${course.name} requirement required ${requiredRequirements.length} others ${otherRequirements.length}');

          // since the required courses are always 5
          // if required requirmeent is 5
          if (requiredRequirements.length == 5) {
            for (UtmeRequirement utmeRequirement in requiredRequirements) {
              if (subjectsOffered.any((subject) =>
                  subject.subject == utmeRequirement.subjectName &&
                  isSubjectGradeQualified(subject.grade))) {
                requiredCount = requiredCount + 1;
                log('found it!!! for required for course ${course.name}');
              } else {
                break;
              }
            }
            log('required count is $requiredCount');
            if (requiredCount == 5) {
              qualifiedCourses.add(course);
              log('course added is ${course.name}');
            }
          } else {
            // check for required requirements
            for (UtmeRequirement utmeRequirement in requiredRequirements) {
              if (subjectsOffered.any((subject) =>
                  subject.subject == utmeRequirement.subjectName &&
                  isSubjectGradeQualified(subject.grade))) {
                requiredCount = requiredCount + 1;
                log('found it!!! for required for course ${course.name}');
              } else {
                break;
              }
            }

            log('required count is $requiredCount');

            // check for other requirements
            int requiredRequirementsNo = requiredRequirements.length;
            int otherRequirementsNo = 5 - requiredRequirementsNo;

            log('others tooo check is $otherRequirementsNo');

            if (otherRequirementsNo != 0) {
              for (int i = 0; i < otherRequirementsNo; i++) {
                if (subjectsOffered.any((subject) =>
                    subject.subject == otherRequirements[i].subjectName &&
                    isSubjectGradeQualified(subject.grade))) {
                  log('found it!!! for others  for course ${course.name}');
                  otherCount = otherCount + 1;
                } else {
                  break;
                }
              }
            }

            log('others count is $otherCount');

            if (requiredCount == requiredRequirementsNo &&
                otherCount == otherRequirementsNo) {
              qualifiedCourses.add(course);
              log('course added is ${course.name}');
            }
          }

          // for (UtmeRequirement utmeRequirement in otherRequirements) {
          //   if (subjectsOffered.any((subject) =>
          //       subject.subject.toLowerCase() == utmeRequirement.subjectName &&
          //       isSubjectGradeQualified(subject.grade))) {
          //     log('found it!!!');
          //   } else {
          //     return [];
          //   }
          // }
        }
      } else {
        return [];
      }
    } catch (e) {
      log('e is ${e.toString()}');
    }
    return qualifiedCourses;
  }

  bool isSubjectGradeQualified(String subjectGrade) {
    if (subjectGrade == 'A1' ||
        subjectGrade == 'B2' ||
        subjectGrade == 'B3' ||
        subjectGrade == 'C4' ||
        subjectGrade == 'C5' ||
        subjectGrade == 'C6') {
      return true;
    } else {
      return false;
    }
  }

  List<SubjectAndGrade> getCourseAndGradeFromFieldParamaters(
      List<FieldParameter> fieldParameters) {
    List<SubjectAndGrade> subjectsAndGrades = [];

    // add all subjects
    for (FieldParameter fp in fieldParameters) {
      if (fp.key.contains('subject')) {
        subjectsAndGrades.add(
          SubjectAndGrade(
            subject: fp.value.result,
            numberSuffix: int.parse(fp.key.split('_').last),
          ),
        );
      }
    }

    // log('subject and grades length is ${subjectsAndGrades.length}');

    // all respective subject grades
    // for (int i = 0; i < fieldParameters.length; i++) {
    //   if (fieldParameters[i].key.contains('grade') &&
    //       int.parse(fieldParameters[i].key.split('_').last) ==
    //           subjectsAndGrades[i].numberSuffix) {
    //     subjectsAndGrades[i].grade = fieldParameters[i].value.result;
    //   }
    // }
    // all respective subject grades
    for (FieldParameter fp in fieldParameters) {
      if (fp.key == 'grade_1') {
        subjectsAndGrades
            .firstWhere((element) => element.numberSuffix == 1)
            .grade = fp.value.result;
      }
      if (fp.key == 'grade_2') {
        subjectsAndGrades
            .firstWhere((element) => element.numberSuffix == 2)
            .grade = fp.value.result;
      }
      if (fp.key == 'grade_3') {
        subjectsAndGrades
            .firstWhere((element) => element.numberSuffix == 3)
            .grade = fp.value.result;
      }
      if (fp.key == 'grade_4') {
        subjectsAndGrades
            .firstWhere((element) => element.numberSuffix == 4)
            .grade = fp.value.result;
      }
      if (fp.key == 'grade_5') {
        subjectsAndGrades
            .firstWhere((element) => element.numberSuffix == 5)
            .grade = fp.value.result;
      }
      if (fp.key == 'grade_6') {
        subjectsAndGrades
            .firstWhere((element) => element.numberSuffix == 6)
            .grade = fp.value.result;
      }
      if (fp.key == 'grade_7') {
        subjectsAndGrades
            .firstWhere((element) => element.numberSuffix == 7)
            .grade = fp.value.result;
      }
      if (fp.key == 'grade_8') {
        subjectsAndGrades
            .firstWhere((element) => element.numberSuffix == 8)
            .grade = fp.value.result;
      }
      if (fp.key == 'grade_9') {
        subjectsAndGrades
            .firstWhere((element) => element.numberSuffix == 9)
            .grade = fp.value.result;
      }
    }

    // for (SubjectAndGrade sg in subjectsAndGrades) {
    //   log('subject and grade is $sg');
    // }

    return subjectsAndGrades;
  }
}
