import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:todo_app/ui/screens/auth/register/register_screen.dart';
import 'package:todo_app/ui/screens/home/home_screen.dart';
import 'package:todo_app/ui/utils/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Login"),
        toolbarHeight: MediaQuery.of(context).size.height * .1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome back !",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                onChanged: (text){
                  email = text;
                },

                decoration: const InputDecoration(
                  label: Text(
                    "Email",
                  ),

                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (text){
                  password = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text("Login", style: TextStyle(fontSize: 18),),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
              const SizedBox(height: 18,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: const Text(
                  "Create account",
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    try{
      DialogUtils.showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      AppUser currentUser = await getUserFromFirestore(userCredential.user!.uid);
      AppUser.currentUser = currentUser;


      DialogUtils.hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }on FirebaseAuthException catch(error){
      DialogUtils.hideLoading(context);
      if(error.code == "INVALID_LOGIN_CREDENTIALS"){
        DialogUtils.showError(context, "Please check your email and password and login again");
      }else {
        DialogUtils.showError(context, error.message ??
            "Some thing went please again later");
      }

    }catch(e){
      DialogUtils.hideLoading(context);
      DialogUtils.showError(context, "Some thing went please again later");
    }
  }

  Future<AppUser> getUserFromFirestore(String uid) async {
    CollectionReference<AppUser> usersCollection = AppUser.collection();
    DocumentReference<AppUser> doc = usersCollection.doc(uid);
    DocumentSnapshot<AppUser> snapshot = await doc.get();
    return snapshot.data()!;
  }
}