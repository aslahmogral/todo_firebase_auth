import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_mtest/model/todo_model.dart';
import 'package:todo_mtest/model/todos.dart';

class TodoProvider with ChangeNotifier {
  final Todos _todos = Todos();
  User? _user;

   User? get user =>_user;
  List<Todo> get todos => _todos.items;

  void add(String title) {
    final todo = Todo(title: title);
    _todos.add(todo);
    notifyListeners();
  }

  void remove(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void toggleDone(Todo todo) {
    _todos.toggleDone(todo);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle errors here
      print(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }

   TodoProvider() {
     FirebaseAuth.instance.authStateChanges().listen((user) {
       _user = user;
       notifyListeners();
     });
   }
}
