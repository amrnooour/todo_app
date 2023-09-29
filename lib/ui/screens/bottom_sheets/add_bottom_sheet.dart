import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_theme.dart';
import 'package:todo_app/ui/widget/my_text_field.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height* .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Add New Task",style: AppTheme.bottomSheetTitleTextStyle,textAlign: TextAlign.center,),
          SizedBox(height: 16,),
          MyTextField(hintText: "Enter task title"),
          SizedBox(height: 8,),
          MyTextField(hintText: "Enter task description"),
          SizedBox(height: 16,),
          Text("Select date",style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.w600),),
          Text("28/9/2023",textAlign: TextAlign.center,style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.normal
          ,color: AppColors.grey),),
          Spacer(),
          ElevatedButton(onPressed: (){}, child: Text("Add")),
        ],
      ),
    );
  }
}
