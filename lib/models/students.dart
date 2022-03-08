import 'dart:convert';

Students studentsFromJson(String str) => Students.fromJson(json.decode(str));

String studentsToJson(Students data) => json.encode(data.toJson());

class Students {
  Students({
    this.students,
    this.marks,
  });

  List<Student>? students;
  List<Mark>? marks;

  factory Students.fromJson(Map<String, dynamic> json) => Students(
        students: List<Student>.from(
            json["students"].map((x) => Student.fromJson(x))),
        marks: List<Mark>.from(json["marks"].map((x) => Mark.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "students": List<dynamic>.from(students!.map((x) => x.toJson())),
        "marks": List<dynamic>.from(marks!.map((x) => x.toJson())),
      };
}

class Mark {
  Mark({
    this.userId,
    this.score,
  });

  int? userId;
  int? score;

  factory Mark.fromJson(Map<String, dynamic> json) => Mark(
        userId: json["user_id"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "score": score,
      };
}

class Student {
  Student({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
