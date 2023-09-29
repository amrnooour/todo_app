import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_theme.dart';

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 22),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),color: AppColors.white),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          extentRatio: .25,
          children: [
            SlidableAction(onPressed: (_){},
              backgroundColor: Colors.red,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
          height: MediaQuery.of(context).size.height*.13,
          child: Row(
            children: [
              VerticalDivider(),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Play BasketBall",style: AppTheme.taskTitleTextStyle,),
                    Text("Description",style: AppTheme.taskDescriptionTextStyle,textAlign: TextAlign.start,),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColors.primiary,),
                padding: EdgeInsets.symmetric(vertical: 6,horizontal: 20),
                  child: Icon(Icons.check,color: AppColors.white,)),
            ],
          ),
        ),
      ),
    );
  }
}
