import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app_last_thing/core/constance/storage_key.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';

class AddTaskController extends ChangeNotifier{
  final GlobalKey<FormState>key = GlobalKey();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  bool isHighPriority = true;

  void addTask(BuildContext context)async{
  if (key.currentState!.validate()) {
    final taskJson = PreferenceManager().getString(StorageKey.tasks);
    List<dynamic> listTasks = [];
    if (taskJson != null) {
      listTasks = jsonDecode(taskJson) as List<dynamic>;
    }
    TaskModel model = TaskModel(
      id: listTasks.length+1,
      taskName: taskNameController.text,
      taskDescription: taskDescriptionController.text,
      isHighPriority: isHighPriority,
    );
    listTasks.add(model.toJson());
    final taskEncode=jsonEncode(listTasks);
    await PreferenceManager().setString(StorageKey.tasks, taskEncode);
    Navigator.of(context).pop(true);
  }
}

  void toggle(bool? value) {
    isHighPriority=value!;
    notifyListeners();
  }
}