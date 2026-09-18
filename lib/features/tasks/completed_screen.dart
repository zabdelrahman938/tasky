import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';
import 'package:tasky_app_last_thing/core/components/task_list_widget.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<TaskModel>completedTasks=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTasks();
  }
  _loadTasks()async{
    final taskJson =PreferenceManager().getString("tasks");
    if(taskJson != null){
      final taskDecode=jsonDecode(taskJson)as List<dynamic>;
      setState(() {
        completedTasks = taskDecode.map((_element)=>TaskModel.fromJson(_element)).toList();
        completedTasks=completedTasks.where((_element)=>_element.isChecked==true).toList();
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
        completedTasks.removeWhere((_element) => _element.id == id);
      });
      final updatedTasks = tasks.map((_element) => _element.toJson()).toList();
      await PreferenceManager().setString("tasks", jsonEncode(updatedTasks));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset("assets/images/arrow_back.svg"),
        title: Text("Completed Tasks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TaskListWidget(
                  tasks: completedTasks,
                  emptyMessage: "No Completed Tasks Found ",
                  onChanged: (bool? value,int? index)async{
                setState(() {
                  completedTasks[index!].isChecked=value??false;
                });

                final allJsonData=PreferenceManager().getString("tasks");
                if(allJsonData !=null){
                  final dataDecode =jsonDecode(allJsonData)as List<dynamic>;
                  final finalData=dataDecode.map((_element)=>TaskModel.fromJson(_element)).toList();
                  final int newIndex = finalData.indexWhere((_element)=>_element.id==completedTasks[index!].id);
                  finalData[newIndex]=completedTasks[index!];
                  await PreferenceManager().setString("tasks", jsonEncode(finalData.map((e)=>e.toJson()).toList()));
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
    );
  }
}
