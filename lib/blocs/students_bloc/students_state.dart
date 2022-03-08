part of 'students_bloc.dart';

abstract class StudentsState {
  const StudentsState();
}

class StudentsLoading extends StudentsState {}

class StudentsLoaded extends StudentsState {
  final Students response;
  final bool isSorted;
  final double average;

  const StudentsLoaded(this.response, this.isSorted, this.average);
}

class StudentsError extends StudentsState {
  final String message;

  const StudentsError(this.message);
}