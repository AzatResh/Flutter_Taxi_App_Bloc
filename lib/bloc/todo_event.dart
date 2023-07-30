import 'package:equatable/equatable.dart';
import 'package:todo/models/item.dart';

abstract class ToDoEvent extends Equatable{
  const ToDoEvent();
}

class TodoListStarted extends ToDoEvent {
  @override
  List<Object> get props => [];
}

class AddToDoEvent extends ToDoEvent{
  final Item todoObj;
  
  const AddToDoEvent({required this.todoObj});

  @override
  List<Object> get props => [todoObj];
}

class RemoveToDoEvent extends ToDoEvent{
  final Item todoObj;
  
  const RemoveToDoEvent({required this.todoObj});

  @override
  List<Object> get props => [todoObj];
}

class ToggleTodoEvent extends ToDoEvent{
  final Item todoObj;
  
  const ToggleTodoEvent({required this.todoObj});

  @override
  List<Object> get props => [todoObj];
}