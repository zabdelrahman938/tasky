import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app_last_thing/features/tasks/tasks_controller.dart';
import 'package:tasky_app_last_thing/core/components/task_list_widget.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});
  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}
class _ToDoScreenState extends State<ToDoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset("assets/images/arrow_back.svg"),
        title: Text("To Do Tasks"),
      ),
      body: ChangeNotifierProvider<TasksController>(
        create: (_) =>TasksController()..init(),
        builder: (BuildContext context,_){
          final controller=context.read<TasksController>();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<TasksController>(
                    builder: (BuildContext context,TasksController value, Widget? child) {
                      return TaskListWidget(
                        tasks: value.toDoTasks,
                        emptyMessage: "No Tasks Found ",
                        onChanged: (bool? value,int? index)async{
                         controller.onChanged(value, index);
                        },
                        onDeleteSelect: (int? id) {
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
          );
        },
      ),
    );
  }
}
