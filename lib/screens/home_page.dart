import 'package:flutter/material.dart';
import 'package:internation_test/screens/books_page.dart';
import 'package:internation_test/constants/sizeconfig.dart';
import 'package:internation_test/screens/students_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(100.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentsPage(),
                    ),
                  );
                },
                child: const Text('Students'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BooksPage(),
                    ),
                  );
                },
                child: const Text('Books'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
