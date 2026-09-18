import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';
import 'package:tasky_app_last_thing/services/preference_manager.dart';
import 'package:tasky_app_last_thing/widgets/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
 const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
List<TaskModel> highPriorityTasks=[];
@override
  void initState() {
    super.initState();
    _loadTasks();
  }
_loadTasks()async{
  final jsonData=PreferenceManager().getString("tasks");
  if(jsonData !=null){
    final decodedTasks=jsonDecode(jsonData)as List<dynamic>;
    setState(() {
      highPriorityTasks=decodedTasks.map((_element)=>TaskModel.fromJson(_element)).toList();
      highPriorityTasks=highPriorityTasks.where((_element)=>_element.isHighPriority==true).toList().reversed.toList();
    });
  }
}
_deleteTask(int? id)async {
  List<TaskModel>tasks=[];
  if(id ==null)return;
  final jsonData=PreferenceManager().getString("tasks");
  if(jsonData !=null) {
    final decodedTasks = jsonDecode(jsonData) as List<dynamic>;
    tasks = decodedTasks.map((_element) => TaskModel.fromJson(_element)).toList();
    tasks.removeWhere((e) => e.id == id);
    setState(() {
      highPriorityTasks.removeWhere((_element) => _element.id == id);
    });
    final updatedTasks = tasks.map((_element) => _element.toJson()).toList();
    await PreferenceManager().setString("tasks", jsonEncode(updatedTasks));
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("High Priority Screen"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
           Expanded(
             child: TaskListWidget(
                 tasks: highPriorityTasks,
                 emptyMessage: "No High Priority Tasks",
                 onChanged: (bool? value,int? index)async{
              setState(() {
                highPriorityTasks[index!].isChecked=value??false;
              });

              final jsonData=PreferenceManager().getString("tasks");
              if(jsonData !=null){
                final dataDecoded=jsonDecode(jsonData)as List<dynamic>;
                final allDataList=dataDecoded.map((_element)=>TaskModel.fromJson(_element)).toList();
                final int newIndex = allDataList.indexWhere((_element)=>_element.id==highPriorityTasks[index!].id);
                allDataList[newIndex]=highPriorityTasks[index!];
                await PreferenceManager().setString("tasks", jsonEncode(allDataList.map((e)=>e.toJson()).toList()));
                _loadTasks();
              }

             }, onDeleteSelect: (int? id) {
                   _deleteTask(id);
             }, onEdit: (){
                   _loadTasks();
             },

             ),
           )
            ],
          ),
        ),
      ),
    );
  }
}
