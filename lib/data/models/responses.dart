class AgentResponses {
  // after the user has provided the nine subjects and their respective grades
  static List<String> getQualifiedCoursesYesResponse = [
    'Got that, I got the five core subjects you offered in Olevel with their respective grades and the four subjects you offered in UTME.',
    'That\'s right, I\'ve got the nine subjects and their grades.',
    'That\'s it; I\'ve figured out the nine subjects and their grades.',
  ];

  static String qualifiedCourseResponse = 'Got that, I got the five core subjects you offered in O\'level with their respective grades and the four subjects you offered in UTME.';
}

class FieldParameter {
  FieldParameter({
    this.key,
    this.value,
  });

  String key;
  Value value;

  factory FieldParameter.fromJson(Map<String, dynamic> json) => FieldParameter(
        key: json["1"],
        value: Value.fromJson(json["2"]),
      );

  Map<String, dynamic> toJson() => {
        "1": key,
        "2": value.toJson(),
      };
}

class Value {
  Value({
    this.result,
  });

  String result;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        result: json["3"],
      );

  Map<String, dynamic> toJson() => {
        "3": result,
      };
}

class SubjectAndGrade {
  String subject;
  String grade;
  int numberSuffix;

  SubjectAndGrade({
    this.subject,
    this.grade,
    this.numberSuffix,
  });

  @override
    String toString() {
      return 'Subject is $subject and Grade is $grade and number is $numberSuffix';
    }
}
