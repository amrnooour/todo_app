import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:todo_app/ui/providers/list_providers.dart';
import 'package:todo_app/ui/screens/home/tabs/list/todo_widget.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.refreshTodosList();
    });

  }

  @override
  Widget build(BuildContext context) {
    provider =Provider.of(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*.14,
          child: Stack(children: [
            Column(
              children: [
                Expanded(flex:3,
                    child: Container(color: AppColors.primiary,)),
                Expanded(flex:7,
                    child: Container(color: AppColors.accent,)),
              ],
            ),
            CalendarTimeline(
              initialDate: provider.selectedDate,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) {
                provider.selectedDate =date;
                provider.refreshTodosList();
              },
              leftMargin: 20,
              monthColor: AppColors.white,
              dayColor: AppColors.primiary,
              activeDayColor: AppColors.primiary,
              activeBackgroundDayColor: AppColors.white,
              dotsColor: AppColors.transparent,
              locale: 'en_ISO',
            ),
          ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: provider.todos.length, itemBuilder: (context, index) => ToDoWidget(model: provider.todos[index],)),
        ),
      ],
    );
  }


}
