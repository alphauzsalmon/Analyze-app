import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internation_test/models/students.dart';
import 'package:internation_test/repos/students_repository.dart';

part 'students_state.dart';
part 'students_event.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final StudentsRepository _repository;
  StudentsBloc(this._repository) : super(StudentsLoading()) {
    on<InitialEvent>(getStudents);
    on<SortedStudentsEvent>(getStudents);
  }

  late Students response;
  late double average;

  Future<void> getStudents(StudentsEvent event, Emitter<StudentsState> emit) async {
    try {
      if (event is InitialEvent) {
        response = await _repository.getStudents();
        average = getAverage(response.students!.length, response.marks!);
        emit(StudentsLoaded(response, false, average));
      } else {
        emit(StudentsLoading());
        final Students students = sort(response);
        emit(StudentsLoaded(students, true, average));
      }
    } catch (err) {
      emit(StudentsError(err.toString()));
    }
  }

  Students sort(Students students) {
    Students supers = Students(students: [], marks: []);
    List<List<int>> scores = [[],];
    for (Student element in students.students!) {
      scores.insert(element.id!, []);
    }
    for (int i = 1; i < scores.length; i++) {
      for (Mark element in students.marks!) {
        if (element.userId == i) {
          scores[i].add(element.score!);
        }
      }
    }
    for (int i = 1; i < scores.length; i++) {
      if (compute(scores[i]) > getAverage(students.students!.length, students.marks!)) {
        supers.students!.add(Student(id: i, name: students.students![i - 1].name));
        supers.marks!.add(Mark(userId: i, score: compute(scores[i])));
      }
    }
    return supers;
  }

  double getAverage(int totalStudents, List<Mark> marks) {
    int totalMarks = 0;
    for (Mark element in marks) {
      totalMarks += element.score!;
    }
    return totalMarks / totalStudents;
  }

  int compute(List<int> scores) {
    int total = 0;
    for (int i in scores) {
      total += i;
    }
    return total;
  }
}

