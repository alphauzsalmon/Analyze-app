import 'package:dio/dio.dart';
import 'package:internation_test/models/students.dart';

abstract class StudentsRepository {
  Future<Students> getStudents();
}

class SampleStudentsRepository extends StudentsRepository {
  @override
  Future<Students> getStudents() async {
    final Response response = await Dio().get('https://jsonkeeper.com/b/AJ2X');
    switch (response.statusCode) {
      case 200:
        return Students.fromJson(response.data);
      default:
        throw('Error ${response.statusCode}');
    }
  }
}