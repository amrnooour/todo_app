import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/todo_dm.dart';

class ListProvider extends ChangeNotifier{
  List<TodoDm> todos =[];
  DateTime selectedDate =DateTime.now();

  refreshTodosList() async {
    CollectionReference<TodoDm> todosCollection =
    FirebaseFirestore.instance.collection(TodoDm.collectionName).
    withConverter<TodoDm>(
        fromFirestore: (docSnapShot, _) {
          Map json = docSnapShot.data() as Map;
          TodoDm todo = TodoDm.fromJson(json);
          return todo;
        },
        toFirestore: (todoDm, _) {
          return todoDm.toJson();
        });
    QuerySnapshot<TodoDm> todosSnapshot = await todosCollection.orderBy("date")
        .get();

    List<QueryDocumentSnapshot<TodoDm>> docs = todosSnapshot.docs;

    ///Better solution
    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();
    todos = todos.where((todo){
      if(todo.date.day != selectedDate.day ||
          todo.date.month != selectedDate.month ||
          todo.date.year != selectedDate.year){
        return false;
      }else {
        return true;
      }
    }).toList();
    notifyListeners();
  }
}