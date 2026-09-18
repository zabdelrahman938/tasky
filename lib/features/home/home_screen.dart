import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';
import 'package:tasky_app_last_thing/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';
import 'package:tasky_app_last_thing/features/add_task/add_task_screen.dart';
import 'package:tasky_app_last_thing/features/home/widgets/achieved_tasks_widget.dart';
import 'package:tasky_app_last_thing/features/home/widgets/high_priority_tasks_widget.dart';
import 'package:tasky_app_last_thing/features/home/widgets/sliver_task_list_widget.dart';
import 'package:tasky_app_last_thing/core/components/task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel>tasks=[];
  bool isChecked=false;
  int doneTasks=0;
  int totalTasks=0;
  double percent=0.0;
  String? userImage;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadTasks();
  }
  _loadUsername()async{
    setState(() {
      username= PreferenceManager().getString("username")??"Guest";
      userImage= PreferenceManager().getString("user_image");
    });
  }
  _loadTasks()async{
   final taskJson=PreferenceManager().getString("tasks");
   if(taskJson !=null){
     final taskDecode=jsonDecode(taskJson)as List<dynamic>;
     setState(() {
       tasks=taskDecode.map((_element)=>TaskModel.fromJson(_element)).toList();
       _calculatePercent();

     });
   }
  }
  _calculatePercent(){
    doneTasks=tasks.where((_element)=>_element.isChecked==true).length;
    totalTasks=tasks.length;
    percent=totalTasks==0?0:doneTasks/totalTasks;
  }
  _doneTask(bool? value,int? index)async{
    setState(() {
      tasks[index!].isChecked=value??false;
      _calculatePercent();
    });
    final updatedTask=tasks.map((_element)=>_element.toJson()).toList();
    await PreferenceManager().setString("tasks", jsonEncode(updatedTask));
  }
  _deleteTask(int? id)async {
    if(id ==null)return;
    setState(() {
      tasks.removeWhere((_element)=>_element.id==id);
      _calculatePercent();
    });
    final updatedTasks=tasks.map((_element)=>_element.toJson()).toList();
   await PreferenceManager().setString("tasks", jsonEncode(updatedTasks));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: ()async{
    final bool? result =await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AddTaskScreen()));
    if (result==true&&result!=null){
       _loadTasks();
                  }
          },
          label: Text(
            "Add New Task",
          ),
        foregroundColor: Color(0xffFFFCFC),
        backgroundColor: Color(0xff15B86C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide.none

        ),
          icon: Icon(Icons.add),
      ),
     body:SafeArea(
       child: Padding(
         padding: const EdgeInsets.all(16.0),
         child: CustomScrollView(
           slivers: [
             SliverToBoxAdapter(
               child:Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       CircleAvatar(
                         backgroundImage: userImage==null?
                         AssetImage("assets/images/person.png"):
                         FileImage(File(userImage!)),
                         backgroundColor: Colors.transparent,
                       ),
                       SizedBox(width:8 ,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             "Good Evening ,$username ",
                             style: Theme.of(context).textTheme.titleMedium
                           ),
                           Text(
                             "One task at a time.One step closer.",
                             style: Theme.of(context).textTheme.titleSmall
                           ),
                         ],
                       )
                     ],
                   ),
                   SizedBox(height: 16,),
                   Text(
                     "Yuhuu ,Your work Is ",
                     style: Theme.of(context).textTheme.titleLarge
                   ),
                   Row(
                     children: [
                       Text(
                         "almost done !  ",
                         style: Theme.of(context).textTheme.titleLarge
                       ),
                       SizedBox(width: 8,),
                       CustomSvgPictureWidget(path: "assets/images/waving-hand.svg", withColorFilter: false)

                     ],
                   ),
                   SizedBox(height: 16,),
                   AchievedTasksWidget(totalTasks:totalTasks, doneTasks: doneTasks, percent: percent,),
                   SizedBox(height: 8,),
                   HighPriorityTasks( onChanged: (bool? value, int? index) {
                     _doneTask(value, index);
                   }, tasks: tasks, loadTask:(){_loadTasks();},),
                   SizedBox(height: 16,),
                   Text(
                     "My Tasks",
                     style: Theme.of(context).textTheme.labelLarge
                   ),
                   SizedBox(height: 16,),
       
       
                 ],
               ),
             ),
             SliverTaskListWidget(
               tasks: tasks,
               emptyMessage: 'NO Data',
               onChanged: (bool? value, int? index) {
               _doneTask(value, index);
       
             }, onDeleteSelect: (int? id) {
                 _deleteTask(id);
             }, onEdit: (){
                 _loadTasks();
             },),

       
           ],
         ),
       ),
     )



    );
  }
}
