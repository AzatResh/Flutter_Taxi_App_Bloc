import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state.dart';
import 'package:todo/models/item.dart';
import 'package:todo/screens/itemCard.dart';
import 'package:todo/screens/todoPage.dart';

void main() {
  runApp(const MainApp());
}
// coverage:ignore-end


//custom keys
final textfieldKey = UniqueKey();
final backButtonKey = UniqueKey();
final logoKey = UniqueKey();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoBloc()..add(TodoListStarted()),
      child: const MaterialApp(home: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget { 

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        appBar: AppBar(

        ),
        body: BlocBuilder<ToDoBloc, ToDoState>(
          builder:(context, state) {
            if(state is ToDoLoadedState){
              List<Item> items = state.items;

              return (
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      TextField(
                            key: textfieldKey,
                            controller: TextEditingController(),
                            keyboardType: TextInputType.none,
                            onTap: () {
                              Navigator.of(context).push(navigateToNewTodoItemPage());
                            },
                            maxLines: 2,
                            style: const TextStyle(fontSize: 20),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.zero), hintText: 'Capture more things on your mind...'),
                            textAlignVertical: TextAlignVertical.top),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 40),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return(
                              Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ItemCard(item: items[index]),
                              )
                            );
                          },
                        )
                      )
                    ],
                  ),
                )
              );
            }
            else{
              return const Center(child: Text("Error loading items list."));
            }
          },
        ),  
      )
    );
  }

  Route navigateToNewTodoItemPage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const NewTodoPage(),
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}
}