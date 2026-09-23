import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app_last_thing/core/widgets/custom_textFormField_widget.dart';
import 'package:tasky_app_last_thing/features/add_task/add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_)=>AddTaskController(),
      builder: (BuildContext context,_) {
        final controller=context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(
            title: Text("New Task"),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormFieldWidget(
                      controller: controller.taskNameController,
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
                        controller: controller.taskDescriptionController,
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium
                        ),
                        Consumer<AddTaskController>(
                          builder: (BuildContext context, AddTaskController value, Widget? child) {
                            return Switch(
                                value: value.isHighPriority,
                                onChanged: (bool? value) {
                                  controller.toggle(value);
                                }
                            );
                          },
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
                        context.read<AddTaskController>().addTask(context);
                      },
                      label: Text(
                        "Add Task",
                      ),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
