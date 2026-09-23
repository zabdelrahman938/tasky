import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app_last_thing/features/tasks/tasks_controller.dart';
import 'package:tasky_app_last_thing/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
 const HighPriorityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>TasksController()..init(),
      builder: (BuildContext context,_){
        final controller = context.read<TasksController>();
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
                    child: Consumer<TasksController>(
                      builder: (BuildContext context, TasksController value, Widget? child) {
                        return TaskListWidget(
                          tasks:value.highPriorityTasks,
                          emptyMessage: "No High Priority Tasks",
                          onChanged: (bool? value,int? index)async{
                            controller.onChangedHighPriorityScreen(value, index);
                          }, onDeleteSelect: (int? id) {
                          controller.deleteTask(id);
                        }, onEdit: (){
                          controller.loadTasks();
                        },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
