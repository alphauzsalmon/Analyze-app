import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internation_test/blocs/students_bloc/students_bloc.dart';
import 'package:internation_test/constants/sizeconfig.dart';
import 'package:internation_test/repos/students_repository.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsBloc>(
      create: (context) => StudentsBloc(
        SampleStudentsRepository(),
      )..add(
          InitialEvent(),
        ),
      child: BlocBuilder<StudentsBloc, StudentsState>(
        builder: (context, state) {
          if (state is StudentsError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(state.message),
              ),
            );
          } else if (state is StudentsLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Students", style: TextStyle(color: Colors.black,),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black),),
              body: Column(
                    children: [
                      SizedBox(
                        height: getHeight(100.0),
                      ),
                      state.isSorted ? Text('Average score: ${state.average}') : const SizedBox(),
                      state.isSorted ? SizedBox(
                        height: getHeight(100.0),
                      ) : const SizedBox(),
                      SizedBox(
                          height: getHeight(400.0),
                          width: double.infinity,
                          child: ListView.builder(
                              itemCount: state.response.students!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                        state.response.students![index].name!),
                                    trailing: state.isSorted
                                        ? Text("Total Score " +
                                            state.response.marks![index].score!
                                                .toString())
                                        : const SizedBox(),
                                  ),
                                );
                              })),
                    ],
                  ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<StudentsBloc>(context)
                      .add(SortedStudentsEvent());
                },
                child: const Text('Sort'),
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
