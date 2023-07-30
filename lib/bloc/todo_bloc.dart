import 'package:bloc/bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state.dart';
import 'package:todo/models/item.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState>{
  ToDoBloc(): super(ToDoInitState()){
    on<TodoListStarted>(_onStart);
    on<AddToDoEvent>(_addTodo);
    on<ToggleTodoEvent>(_toggleTodo);
  }

  _onStart(TodoListStarted event, Emitter<ToDoState> emit){
    emit(const ToDoLoadedState(items: []));
  }

  _addTodo(AddToDoEvent event, Emitter<ToDoState> emit) {
    final state = this.state;
    if (state is ToDoLoadedState) {
      emit(ToDoLoadedState(items: [...state.items, event.todoObj]));
    }
  }
  _toggleTodo(ToggleTodoEvent event, Emitter<ToDoState> emit) {
    final state = this.state;
    if (state is ToDoLoadedState) {
      List<Item> items = List.from(state.items);
      int indexToChange =
          items.indexWhere((element) => element.id == event.todoObj.id);

      if (indexToChange != -1) {
        Item itemToChange = items[indexToChange];
        Item updatedItem = Item(
            description: itemToChange.description,
            completed: !itemToChange.completed);

        items[indexToChange] = updatedItem;
      }

      emit(ToDoLoadedState(items: [...items]));
    }
  }

  _removeTodo(RemoveToDoEvent event, Emitter<ToDoState> emit) {
    final state = this.state;

    if (state is ToDoLoadedState) {
      List<Item> items = state.items;
      items.removeWhere((element) => element.id == event.todoObj.id);

      emit(ToDoLoadedState(items: items));
    }
  }
}

