import 'dart:developer';

import 'package:chatbot/data/models/course.dart';
import 'package:chatbot/data/models/responses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialogflow_grpc/generated/google/protobuf/type.pb.dart';

class CoursesService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Course>> getQualifiedCourses(
      List<FieldParameter> utmeFieldParameters,
      List<FieldParameter> olevelFieldParameters) async {
    List<Course> qualifiedOlevelCourses = [];
    List<Course> qualifiedCourses = [];
    List<Course> coursesFromFirebase = [];
    int requiredOlevelCount = 0;
    int requiredUtmeCount = 0;
    int otherOlevelCount = 0;
    int otherUtmeCount = 0;

    try {
      DocumentSnapshot documentSnapshot =
          await firebaseFirestore.collection('courses').doc('sciences').get();

      if (documentSnapshot.exists) {
        Map course = documentSnapshot.data();
        for (Map department in course['departments']) {
          coursesFromFirebase.add(Course.fromJson(department));
        }
        List<SubjectAndGrade> subjectsOffered =
            getCourseAndGradeFromFieldParamaters(olevelFieldParameters);

        // FILTER FOR OLEVEL COURSES
        for (Course course in coursesFromFirebase) {
          requiredOlevelCount = 0;
          otherOlevelCount = 0;

          List<OlevelRequirements> requiredOlevelRequirements = course
              .olevelRequirements
              .where((element) => element.isRequired == true)
              .toList();
          List<OlevelRequirements> otherOlevelRequirements = course
              .olevelRequirements
              .where((element) => element.isRequired == false)
              .toList();

          log('course name is ${course.name} requirement required ${requiredOlevelRequirements.length} others ${otherOlevelRequirements.length} for o level');

          // since the required courses are always 5
          // if required requirmeent is 5
          if (requiredOlevelRequirements.length == 5) {
            for (OlevelRequirements olevelRequirement
                in requiredOlevelRequirements) {
              if (subjectsOffered.any((subject) =>
                  subject.subject == olevelRequirement.subjectName &&
                  isSubjectGradeQualified(subject.grade))) {
                requiredOlevelCount = requiredOlevelCount + 1;
                log('found it!!! for required for course ${course.name} o level requirement');
              } else {
                break;
              }
            }
            log('required count is $requiredOlevelCount o level req');
            if (requiredOlevelCount == 5) {
              qualifiedOlevelCourses.add(course);
              log('course added is ${course.name} o level req');
            }
          } else {
            // check for required requirements
            for (OlevelRequirements olevelRequirement
                in requiredOlevelRequirements) {
              if (subjectsOffered.any((subject) =>
                  subject.subject == olevelRequirement.subjectName &&
                  isSubjectGradeQualified(subject.grade))) {
                requiredOlevelCount = requiredOlevelCount + 1;
                log('found it!!! for required for course ${course.name} o level req');
              } else {
                break;
              }
            }

            log('required count is $requiredOlevelCount o level req');

            // check for other requirements
            int requiredRequirementsNo = requiredOlevelRequirements.length;
            int otherRequirementsNo = 5 - requiredRequirementsNo;

            log('others tooo check is $otherRequirementsNo o level req');

            if (otherRequirementsNo != 0) {
              for (int i = 0; i < otherRequirementsNo; i++) {
                if (subjectsOffered.any((subject) =>
                    subject.subject == otherOlevelRequirements[i].subjectName &&
                    isSubjectGradeQualified(subject.grade))) {
                  log('found it!!! for others  for course ${course.name} o level req');
                  otherOlevelCount = otherOlevelCount + 1;
                } else {
                  break;
                }
              }
            }

            log('others count is $otherOlevelCount o level req');

            if (requiredOlevelCount == requiredRequirementsNo &&
                otherOlevelCount == otherRequirementsNo) {
              qualifiedOlevelCourses.add(course);
              log('course added is ${course.name} o level req');
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

      // FILTER UTME subjects
      for (Course c in qualifiedOlevelCourses) {
        requiredUtmeCount = 0;
        otherUtmeCount = 0;

        // UTME subjects
        List<String> utmeSubjectsOffered =
            getUTMESubjectsFromFieldParameters(utmeFieldParameters);

        log('======= UTME subjects offered are $utmeSubjectsOffered');

        List<UtmeRequirement> requiredUtmeRequirements = c.utmeRequirements
            .where((element) => element.isRequired == true)
            .toList();
        List<UtmeRequirement> otherUtmeRequirements = c.utmeRequirements
            .where((element) => element.isRequired == false)
            .toList();

          log('course name is ${c.name} requirement required ${requiredUtmeRequirements.length} others ${otherUtmeRequirements.length} for o level');

        // deeling with this qualifiedCourses
        if (requiredUtmeRequirements.length == 4) {
          for (UtmeRequirement utmeRequirement in requiredUtmeRequirements) {
            if (utmeSubjectsOffered
                .any((subject) => subject == utmeRequirement.subjectName)) {
              requiredUtmeCount = requiredUtmeCount + 1;
              log('found it!!! for required for course ${c.name} utme req');
            } else {
              break;
            }
          }
          log('required count is $requiredUtmeCount utme req');
          if (requiredUtmeCount == 4) {
            qualifiedCourses.add(c);
            log('course added is ${c.name} utme req');
          }
        } else {
          for (UtmeRequirement utmeRequirement in requiredUtmeRequirements) {
            if (utmeSubjectsOffered
                .any((subject) => subject == utmeRequirement.subjectName)) {
              requiredUtmeCount = requiredUtmeCount + 1;
              log('found it!!! for required for course ${c.name} utme req');
            } 
            else {
              break;
            }
          }

          log('required count is $requiredUtmeCount utme req');

          // check for other requirements
          int requiredRequirementsNo = requiredUtmeRequirements.length;
          int otherRequirementsNo = 4 - requiredRequirementsNo;

          log('others tooo check is $otherRequirementsNo utme req');

          if (otherRequirementsNo != 0) {
            for (int i = 0; i < otherRequirementsNo; i++) {
              if (utmeSubjectsOffered.any((subject) =>
                  subject == otherUtmeRequirements[i].subjectName)) {
                log('found it!!! for others  for course ${c.name} utme req');
                otherUtmeCount = otherUtmeCount + 1;
              } else {
                break;
              }
            }
          }

          log('others count is $otherOlevelCount utme req');

          if (requiredUtmeCount == requiredRequirementsNo &&
              otherUtmeCount == otherRequirementsNo) {
            qualifiedCourses.add(c);
            log('course added is ${c.name} utme req');
          }
        }

        // continue your thing
      }
    } catch (e) {
      log('e is ${e.toString()}');
    }
    return qualifiedCourses;
  }

  furtherFilterCoursesBasedOnUTME() {}

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

  List<String> getUTMESubjectsFromFieldParameters(
      List<FieldParameter> fieldParameters) {
    List<String> subjects = [];

    for (FieldParameter fp in fieldParameters) {
      if (fp.key.contains('utme')) {
        subjects.add(
          fp.value.result,
        );
      }
    }

    return subjects;
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
