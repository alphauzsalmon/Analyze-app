part of 'books_bloc.dart';

abstract class BooksState {
  const BooksState();
}

class BooksLoading extends BooksState {}

class BooksLoaded extends BooksState {
  final Books response;
  final bool isSorted;
  final double difference;
  final int times;

  const BooksLoaded(this.response, this.isSorted, this.difference, this.times);
}

class BooksError extends BooksState {
  final String message;

  const BooksError(this.message);
}