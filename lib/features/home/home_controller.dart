
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app_last_thing/core/constance/storage_key.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';

class HomeController extends ChangeNotifier{

  List<TaskModel>tasksList=[];
  String? username;
  List<TaskModel>tasks=[];
  bool isChecked=false;
  int doneTasks=0;
  int totalTasks=0;
  double percent=0.0;
  String? userImage;
  init(){
    loadUsername();
    loadTasks();
  }
  loadUsername()async{

      username= PreferenceManager().getString("username")??"Guest";
      userImage= PreferenceManager().getString("user_image");
    notifyListeners();
  }
  loadTasks()async{
    final taskJson=PreferenceManager().getString(StorageKey.tasks);
    if(taskJson !=null){
      final taskDecode=jsonDecode(taskJson)as List<dynamic>;
        tasks=taskDecode.map((_element)=>TaskModel.fromJson(_element)).toList();
        calculatePercent();

    notifyListeners();
    }
  }
  calculatePercent(){
    doneTasks=tasks.where((_element)=>_element.isChecked==true).length;
    totalTasks=tasks.length;
    percent=totalTasks==0?0:doneTasks/totalTasks;
  }
  doneTask(bool? value,int? index)async{

      tasks[index!].isChecked=value??false;
      calculatePercent();

    final updatedTask=tasks.map((_element)=>_element.toJson()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }
  deleteTask(int? id)async {
    if(id ==null)return;

      tasks.removeWhere((_element)=>_element.id==id);
      calculatePercent();

    final updatedTasks=tasks.map((_element)=>_element.toJson()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTasks));
    notifyListeners();
  }
}