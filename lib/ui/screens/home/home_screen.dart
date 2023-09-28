import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName ="home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
    );
  }

  PreferredSizeWidget buildAppBar(){
    return AppBar(title: Text("To Do List"),
    toolbarHeight: MediaQuery.of(context).size.height * .2,
    );
  }
}
