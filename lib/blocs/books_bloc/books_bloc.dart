import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internation_test/models/books.dart';
import 'package:internation_test/repos/books_repository.dart';

part 'books_state.dart';
part 'books_event.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepository _repository;
  BooksBloc(this._repository) : super(BooksLoading()) {
    on<InitialEvent>(getBooks);
    on<SortedBooks>(getBooks);
  }

  late Books response;
  late int max;

  Future<void> getBooks(BooksEvent event, Emitter<BooksState> emit) async {
    try {
      if (event is InitialEvent) {
        response = await _repository.getBooks();
        emit(BooksLoaded(response, false, 0.0, 0));
      } else {
        emit(BooksLoading());
        Book book = getBestSeller(response);
        final double difference = calculateDifference(response.sold!);
        final Books books = Books(books: [book], sold: []);
        emit(BooksLoaded(books, true, difference, max));
      }
    } catch (err) {
      emit(BooksError(err.toString()));
    }
  }

  Book getBestSeller(Books books) {
    late Book book;
    List<int> soldBooks = [];
    for (int i = 0; i < books.books!.length; i++) {
      soldBooks.insert(i, 0);
    }
    for (int i = 0; i < books.books!.length; ++i) {
      for (Sold element in books.sold!) {
        if (element.bookId == books.books![i].id!) {
          soldBooks[i]++;
        }
      }
    }
    max = 0;
    int id = 0;
    for (int i = 0; i < soldBooks.length; ++i) {
      if (soldBooks[i] > max) {
        max = soldBooks[i];
        id = i + 1;
      }
    }
    for (Book element in books.books!) {
      if (element.id == id) {
        book = element;
      }
    }
    return book;
  }

  double calculateDifference(List<Sold> sold) {
    List<List<Sold>> data = sortSold(sold);
    final int sixthMarch = totalSold(data.first);
    final int seventhMarch = totalSold(data.last);
    final double difference = (sixthMarch - seventhMarch) / (sixthMarch / 100);
    return difference;
  }

  List<List<Sold>> sortSold(List<Sold> sold) {
    List<List<Sold>> data = [[],[]];
    for (Sold element in sold) {
      if (element.date == DateTime(2021, 3, 6)) {
        data.first.add(element);
      } else if (element.date == DateTime(2021, 3, 7)) {
        data.last.add(element);
      }
    }
    return data;
  }

  int totalSold(List<Sold> sold) {
    int total = 0;
    for (int j = 0; j < sold.length; ++j) {
      total++;
    }
    return total;
  }
}