import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:todo_app/models/todo_dm.dart';
import 'package:todo_app/ui/providers/list_providers.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_theme.dart';
import 'package:todo_app/ui/widget/my_text_field.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  DateTime selectedDate =DateTime.now();
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height* .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Add New Task",style: AppTheme.bottomSheetTitleTextStyle,textAlign: TextAlign.center,),
          SizedBox(height: 16,),
          MyTextField(hintText: "Enter task title",controller: titleController,),
          SizedBox(height: 8,),
          MyTextField(hintText: "Enter task description",controller: descriptionController,),
          SizedBox(height: 16,),
          Text("Select date",style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.w600),),
          InkWell(
            onTap: (){
              showMyDatePicker();
            },
            child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",textAlign: TextAlign.center,style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.normal
            ,color: AppColors.grey),),
          ),
          Spacer(),
          ElevatedButton(onPressed: (){
            addToDoFireStore();
          }, child: Text("Add")),
        ],
      ),
    );
  }

  void addToDoFireStore() async{
    CollectionReference todosCollectionRef =
    AppUser.collection().doc(AppUser.currentUser!.id).collection(TodoDm.collectionName);
    DocumentReference newEmptyDoc = todosCollectionRef.doc();
    await newEmptyDoc.set({
      "id" : newEmptyDoc.id,
      "title" : titleController.text,
      "description" : descriptionController.text,
      "date" : selectedDate.millisecondsSinceEpoch,
      "isDone" : false,
    });
    provider.refreshTodosList();
    Navigator.pop(context);
  }

  void showMyDatePicker() async{
    selectedDate = await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))) ?? selectedDate;
    setState(() {
    });
  }
}
