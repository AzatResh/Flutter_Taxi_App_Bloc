import 'package:equatable/equatable.dart';
import 'package:todo/models/item.dart';

abstract class ToDoState extends Equatable{
  const ToDoState();
}

class ToDoInitState extends ToDoState{
  @override
  List<Object> get props => [];
}

class ToDoLoadedState extends ToDoState{
  final List<Item> items;
  const ToDoLoadedState({this.items = const[]});

  @override
  List<Object> get props => [items];
}

class ToDoListErrorState extends ToDoState {
  @override
  List<Object> get props => [];
}