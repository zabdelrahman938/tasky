import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app_last_thing/enums/task_item_action_enum.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';
import 'package:tasky_app_last_thing/services/preference_manager.dart';
import 'package:tasky_app_last_thing/themes/theme_controller.dart';
import 'package:tasky_app_last_thing/widgets/custom_checkBox_widget.dart';
import 'package:tasky_app_last_thing/widgets/custom_textFormField_widget.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDeleteSelect,
    required this.onEdit,
  });

  final TaskModel task;
  final Function(bool? value) onChanged;
  final Function(int) onDeleteSelect;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.all(5),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.themeNotifier.value == ThemeMode.light
              ? Color(0xffD1DAD6)
              : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          CustomCheckboxWidget(
            value: task.isChecked,
            onChanged: (bool? value) async {
              onChanged(value);
            },
          ),
          SizedBox(width: 8),
         Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                      task.taskName,
                      style: task.isChecked
                          ? Theme.of(context).textTheme.headlineSmall
                          : Theme.of(context).textTheme.titleMedium,
                    ),
                  if (task.taskDescription.isNotEmpty)
                    Text(
                      task.taskDescription,
                      style: task.isChecked
                          ? Theme.of(
                              context,
                            ).textTheme.headlineSmall!.copyWith(fontSize: 14)
                          : Theme.of(context).textTheme.titleSmall,
                    ),
                ],
              ),

          ),
          Spacer(),
          PopupMenuButton<TaskItemActionEnum>(
            icon: Icon(
              Icons.more_vert,
              color: task.isChecked
                  ? ThemeController.themeNotifier.value == ThemeMode.dark
                        ? Color(0xffA0A0A0)
                        : Color(0xff6A6A6A)
                  : ThemeController.themeNotifier.value == ThemeMode.dark
                  ? Color(0xffC6C6C6)
                  : Color(0xff3A4640),
            ),
            onSelected: (value)async {
              switch (value) {
                case TaskItemActionEnum.MarkAsDone:
                  onChanged(!task.isChecked);
                case TaskItemActionEnum.Edit:
                final result =  await _showButtonSheet(context, task);
                if(result!=null&&result==true){
                 onEdit();
                }
                case TaskItemActionEnum.Delete:
                  await _showAlertDialog(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return TaskItemActionEnum.values.map((e) {
                return PopupMenuItem<TaskItemActionEnum>(
                  value: e,
                  child: Text(e.name, style: TextStyle(fontSize: 16)),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

   _showAlertDialog(BuildContext context) {
     showDialog(
      context: context,
      builder: (BuildContext context) {
      return  AlertDialog(
          title: Text(
            "Delete Task",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 20,
              color: ThemeController.themeNotifier.value == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          content: Text("Are You sure you want to delete this task"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onDeleteSelect(task.id);
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtonSheet(BuildContext context,TaskModel model)  {
    TextEditingController taskNameController = TextEditingController(text: model.taskName);
    TextEditingController taskDescriptionController = TextEditingController(text: model.taskDescription);
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    bool isHighPriority=model.isHighPriority;
   return showModalBottomSheet(
      context: context,
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return  StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return  Padding(
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
                          style: Theme.of(context).textTheme.titleMedium,
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
                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text,
                            taskDescription: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            isChecked: model.isChecked
                          );
                         final item = listTasks.firstWhere((_element)=>_element["id"]==model.id);
                       final int index =  listTasks.indexOf(item);
                       listTasks[index]=newModel;
                          final taskEncode=jsonEncode(listTasks);
                          await PreferenceManager().setString("tasks", taskEncode);
                          Navigator.of(context).pop(true);
                        }
                      },
                      label: Text(
                        "Edit Task",
                      ),
                      icon: Icon(Icons.edit),
                    )
                  ],
                ),
              ),
            );
          },

        );
      },
    );
  }
}
