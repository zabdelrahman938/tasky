import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app_last_thing/core/constance/storage_key.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';

class TasksController extends ChangeNotifier{
List<TaskModel>tasks=[];
List<TaskModel>toDoTasks=[];
List<TaskModel>completedTasks=[];
List<TaskModel>highPriorityTasks=[];

init(){
  loadTasks();
}
void loadTasks(){
  final taskJson=PreferenceManager().getString(StorageKey.tasks);
  if(taskJson !=null) {
    final taskDecode = jsonDecode(taskJson) as List<dynamic>;
    tasks = taskDecode.map((_element) => TaskModel.fromJson(_element)).toList();
    toDoTasks=tasks.where((_element)=>_element.isChecked==false).toList();
    completedTasks=tasks.where((_element)=>_element.isChecked==true).toList();
    highPriorityTasks=tasks.where((_element)=>_element.isHighPriority==true).toList().reversed.toList();
    notifyListeners();
  }

}

onChanged(bool? value,int? index)async{
  if(index==null)return;
    toDoTasks[index].isChecked=value??false;
    final int newIndex = tasks.indexWhere((_element)=>_element.id==toDoTasks[index].id);
    tasks[newIndex]=toDoTasks[index];
    await  PreferenceManager().setString(StorageKey.tasks, jsonEncode(tasks.map((e)=>e.toJson()).toList()));
    loadTasks();
  notifyListeners();
}
onChangedCompleteScreen(bool? value,int? index)async{
  if(index==null)return;
  completedTasks[index].isChecked=value??false;
  final int newIndex = tasks.indexWhere((_element)=>_element.id==completedTasks[index].id);
  tasks[newIndex]=completedTasks[index];
  await  PreferenceManager().setString(StorageKey.tasks, jsonEncode(tasks.map((e)=>e.toJson()).toList()));
  loadTasks();
  notifyListeners();
}

onChangedHighPriorityScreen(bool? value,int? index)async{
  if(index==null)return;
  highPriorityTasks[index].isChecked=value??false;
  final int newIndex = tasks.indexWhere((_element)=>_element.id==highPriorityTasks[index].id);
  tasks[newIndex]=highPriorityTasks[index];
  await  PreferenceManager().setString(StorageKey.tasks, jsonEncode(tasks.map((e)=>e.toJson()).toList()));
  loadTasks();
  notifyListeners();
}
deleteTask(int? id)async {
  if(id ==null)return;
     tasks.removeWhere((e) => e.id == id);
     toDoTasks.removeWhere((_element) => _element.id == id);
     completedTasks.removeWhere((_element) => _element.id == id);
     highPriorityTasks.removeWhere((_element) => _element.id == id);
    final updatedTasks = tasks.map((_element) => _element.toJson()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTasks));
    notifyListeners();
}
}