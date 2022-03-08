import 'dart:convert';

Books booksFromJson(String str) => Books.fromJson(json.decode(str));

String booksToJson(Books data) => json.encode(data.toJson());

class Books {
  Books({
    this.books,
    this.sold,
  });

  List<Book>? books;
  List<Sold>? sold;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
    books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
    sold: List<Sold>.from(json["sold"].map((x) => Sold.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "books": List<dynamic>.from(books!.map((x) => x.toJson())),
    "sold": List<dynamic>.from(sold!.map((x) => x.toJson())),
  };
}

class Book {
  Book({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Sold {
  Sold({
    this.bookId,
    this.date,
  });

  int? bookId;
  DateTime? date;

  factory Sold.fromJson(Map<String, dynamic> json) => Sold(
    bookId: json["book_id"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "book_id": bookId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  };
}
