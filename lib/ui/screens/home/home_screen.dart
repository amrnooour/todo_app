import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:todo_app/ui/providers/list_providers.dart';
import 'package:todo_app/ui/screens/auth/login/login_screen.dart';
import 'package:todo_app/ui/screens/bottom_sheets/add_bottom_sheet.dart';
import 'package:todo_app/ui/screens/home/tabs/list/list_tab.dart';
import 'package:todo_app/ui/screens/home/tabs/settings/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName ="home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedTabIndex =0;
  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider =Provider.of(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: currentSelectedTabIndex ==0 ? ListTab() : SettingsTab(),
      bottomNavigationBar: buildBottomNav(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget buildAppBar(){
    return AppBar(
      title: Text("Welcome ${AppUser.currentUser!.username}"),
    toolbarHeight: MediaQuery.of(context).size.height * .1,
      actions: [
        InkWell(
            onTap: (){
              AppUser.currentUser = null;
              provider.todos.clear();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: Icon(Icons.logout))
      ],
    );
  }

 Widget buildBottomNav() {
    return BottomAppBar(
      notchMargin: 8,
      shape: CircularNotchedRectangle(),
      clipBehavior:  Clip.hardEdge,
      child: BottomNavigationBar(
          onTap: (index){
            currentSelectedTabIndex =index;
            setState(() {
            });
          },
          currentIndex: currentSelectedTabIndex,
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.menu),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: ""),
      ]),
    );
 }

  Widget buildFab() => FloatingActionButton(onPressed: (){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder: (_) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: AddBottomSheet(),
    ));
  },
  child: const Icon(Icons.add),
  );
}
