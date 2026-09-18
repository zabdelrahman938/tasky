import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';
import 'package:tasky_app_last_thing/core/widgets/custom_textFormField_widget.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState>_key = GlobalKey();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormFieldWidget(
                  controller: taskNameController,
                  title: "Task Name",
                  hintText: "Finish UI design for login screen",
                  maxLines: 1,
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return "please enter your task name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                CustomTextFormFieldWidget(
                    controller: taskDescriptionController,
                    title: "Task Description",
                    hintText: "Finish onboarding UI and hand off to devs by Thursday.",
                    maxLines: 5
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "High Priority ",
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                    Switch(
                        value: isHighPriority,
                        onChanged: (bool? value) {
                       setState(() {
                         isHighPriority=value!;
                       });
                        }
                    )

                  ],
                ),
                Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery
                          .of(context)
                          .size
                          .width, 45)
                  ),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      final taskJson = PreferenceManager().getString("tasks");
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
                      await PreferenceManager().setString("tasks", taskEncode);
                      Navigator.of(context).pop(true);
                    }
                  },
                  label: Text(
                    "Add Task",
                  ),
                  icon: Icon(Icons.add),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
