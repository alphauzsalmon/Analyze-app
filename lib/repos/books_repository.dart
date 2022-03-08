import 'package:dio/dio.dart';
import 'package:internation_test/models/books.dart';

abstract class BooksRepository {
  Future<Books> getBooks();
}

class SampleBooksRepository extends BooksRepository {
  @override
  Future<Books> getBooks() async {
    final Response response = await Dio().get('https://jsonkeeper.com/b/LDPQ');
    switch (response.statusCode) {
      case 200:
        return Books.fromJson(response.data);
      default:
        throw('Error ${response.statusCode}');
    }
  }
}