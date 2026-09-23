import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app_last_thing/features/tasks/tasks_controller.dart';
import 'package:tasky_app_last_thing/core/components/task_list_widget.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset("assets/images/arrow_back.svg"),
        title: Text("Completed Tasks"),
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
                        tasks: value.completedTasks,
                        emptyMessage: "No Completed Tasks Found ",
                        onChanged: (bool? value,int? index)async{
                          controller.onChangedCompleteScreen(value, index);
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
          );
        },

      ),
    );
  }
}
