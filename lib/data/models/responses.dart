class AgentResponses {
  // after the user has provided the nine subjects and their respective grades
  static List<String> getQualifiedCoursesYesResponse = [
    'Got that, I got the nine subjects and their respective grades.',
    'That\'s right, I\'ve got the nine subjects and their grades.',
    'That\'s it; I\'ve figured out the nine subjects and their grades.',
  ];
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
