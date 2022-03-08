import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internation_test/blocs/books_bloc/books_bloc.dart';
import 'package:internation_test/constants/sizeconfig.dart';
import 'package:internation_test/repos/books_repository.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BooksBloc>(
      create: (context) => BooksBloc(
        SampleBooksRepository(),
      )..add(
          InitialEvent(),
        ),
      child: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          if (state is BooksError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(state.message),
              ),
            );
          } else if (state is BooksLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Books",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: getHeight(100.0),
                  ),
                  state.isSorted
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(20.0),
                          ),
                          child: Text(
                              'On 7th March, sales were down ${state.difference.toStringAsFixed(2)} % from 6th March'),
                        )
                      : const SizedBox(),
                  state.isSorted
                      ? SizedBox(
                          height: getHeight(100.0),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: getHeight(400.0),
                    child: ListView.builder(
                        itemCount: state.response.books!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(state.response.books![index].name!),
                              subtitle: state.isSorted
                                  ? const Text('The Bestseller')
                                  : const SizedBox(),
                              trailing: state.isSorted
                                  ? Text('${state.times} times sold')
                                  : const SizedBox(),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<BooksBloc>(context).add(
                    SortedBooks(),
                  );
                },
                child: const Icon(Icons.analytics),
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
