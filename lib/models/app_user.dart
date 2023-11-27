import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo_dm.dart';

class AppUser{
  static const String collectionName = "users";
  static AppUser? currentUser;
  late String id;
  late String email;
  late String username;

  AppUser({required this.id, required this.email, required this.username});

  AppUser.fromJson(Map json){
    id = json["id"];
    email = json["email"];
    username = json["username"];
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "email": email,
      "username": username
    };
  }

  static CollectionReference<AppUser> collection(){
    return FirebaseFirestore.instance.collection(AppUser.collectionName)
        .withConverter<AppUser>(
        fromFirestore: (snapshot, _){
          return AppUser.fromJson(snapshot.data()!);
        },
        toFirestore: (user, _){
          return user.toJson();
        });
  }
  static CollectionReference getCurrentUserTodosCollection(){
    return AppUser.collection().doc(AppUser.currentUser!.id)
        .collection(TodoDm.collectionName);
  }
}