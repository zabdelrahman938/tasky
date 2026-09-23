import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/core/themes/theme_controller.dart';
import 'package:tasky_app_last_thing/features/home/home_controller.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';
import 'package:tasky_app_last_thing/core/components/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key, required this.emptyMessage});
//final List<TaskModel>tasks;
final String emptyMessage;



  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
        builder: (BuildContext context,HomeController controller,Widget? child){
          return controller.tasks.isEmpty?
          SliverToBoxAdapter(child: Center(child: Text(emptyMessage,style: TextStyle(color:ThemeController.themeNotifier.value==ThemeMode.dark? Colors.white:Color(0xff161F1B) ,fontSize: 25),),))
              : SliverPadding(
            padding:EdgeInsets.only(bottom: 90),
            sliver: SliverList.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:TaskItemWidget(task: controller.tasks[index], onChanged: (bool? value) {
                        controller.doneTask(value,index);
                      }, onDeleteSelect: (int id) {
                        controller.deleteTask(id);
                      }, onEdit: (){controller.loadTasks();},)

                  );
                }
            ),
          );
        }
    );
  }
}
