part of 'books_bloc.dart';

abstract class BooksEvent {}

class InitialEvent extends BooksEvent {}

class SortedBooks extends BooksEvent {}