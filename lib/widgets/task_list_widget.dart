import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';
import 'package:tasky_app_last_thing/themes/theme_controller.dart';
import 'package:tasky_app_last_thing/widgets/custom_checkBox_widget.dart';
import 'package:tasky_app_last_thing/widgets/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key, required this.tasks, required this.emptyMessage, required this.onChanged, required this.onDeleteSelect, required this.onEdit});
final List<TaskModel>tasks;
final String emptyMessage;
final Function (bool? value,int? index)onChanged;
final Function (int? id)onDeleteSelect;
  final Function onEdit;


  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty?
    Center(child: Text(emptyMessage,style: TextStyle(color:ThemeController.themeNotifier.value==ThemeMode.dark? Colors.white:Color(0xff161F1B),fontSize: 25),),)
        : ListView.builder(
        padding: EdgeInsets.only(bottom: 90),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context,int index){
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TaskItemWidget(task: tasks[index], onChanged: (bool?value){
              onChanged(value,index);
            }, onDeleteSelect: (int id) {
             onDeleteSelect(id);
            }, onEdit: (){
              onEdit();
            },),
          );
        }
    );
  }
}
