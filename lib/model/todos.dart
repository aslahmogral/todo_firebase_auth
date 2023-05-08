import 'package:todo_mtest/model/todo_model.dart';

class Todos {
  List<Todo> _items = [];

  List<Todo> get items => _items;

  void add(Todo todo) {
    _items.add(todo);
  }

  void remove(Todo todo) {
    _items.remove(todo);
  }

  void toggleDone(Todo todo) {
    todo.toggleDone();
  }
}
