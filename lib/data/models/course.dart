// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

Course courseFromJson(String str) => Course.fromJson(json.decode(str));

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  Course({
    this.faculty,
    this.name,
    this.universities,
    this.utmeRequirements,
    this.olevelRequirements,
  });

  String faculty;
  String name;
  Universities universities;
  List<UtmeRequirement> utmeRequirements;
  List<OlevelRequirements> olevelRequirements;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        faculty: json["faculty"],
        name: json["name"],
        universities: Universities.fromJson(json["universities"]),
        utmeRequirements: List<UtmeRequirement>.from(
          json["utme_requirements"].map(
            (x) => UtmeRequirement.fromJson(x),
          ),
        ),
        olevelRequirements: List<OlevelRequirements>.from(
          json["olevel_requirements"].map(
            (x) => OlevelRequirements.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "faculty": faculty,
        "name": name,
        "universities": universities.toJson(),
        "utme_requirements": List<dynamic>.from(
          utmeRequirements.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class Universities {
  Universities({
    this.federal,
    this.private,
    this.state,
  });

  List<String> federal;
  List<String> private;
  List<String> state;

  factory Universities.fromJson(Map<String, dynamic> json) => Universities(
        federal: List<String>.from(json["federal"].map((x) => x)),
        private: List<String>.from(json["private"].map((x) => x)),
        state: List<String>.from(json["state"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "federal": List<dynamic>.from(federal.map((x) => x)),
        "private": List<dynamic>.from(private.map((x) => x)),
        "state": List<dynamic>.from(state.map((x) => x)),
      };
}

class UtmeRequirement {
  UtmeRequirement({
    this.isRequired,
    this.subjectName,
  });

  bool isRequired;
  String subjectName;

  factory UtmeRequirement.fromJson(Map<String, dynamic> json) =>
      UtmeRequirement(
        isRequired: json["is_required"],
        subjectName: json["subject_name"],
      );

  Map<String, dynamic> toJson() => {
        "is_required": isRequired,
        "subject_name": subjectName,
      };
}

class OlevelRequirements {
  OlevelRequirements({
    this.isRequired,
    this.subjectName,
  });

  bool isRequired;
  String subjectName;

  factory OlevelRequirements.fromJson(Map<String, dynamic> json) =>
      OlevelRequirements(
        isRequired: json["is_required"],
        subjectName: json["subject_name"],
      );

  Map<String, dynamic> toJson() => {
        "is_required": isRequired,
        "subject_name": subjectName,
      };
}
