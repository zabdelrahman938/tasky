import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app_last_thing/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app_last_thing/features/home/home_controller.dart';
import 'package:tasky_app_last_thing/features/add_task/add_task_screen.dart';
import 'package:tasky_app_last_thing/features/home/widgets/achieved_tasks_widget.dart';
import 'package:tasky_app_last_thing/features/home/widgets/high_priority_tasks_widget.dart';
import 'package:tasky_app_last_thing/features/home/widgets/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context)=>HomeController()..init(),
      child: Consumer(
        builder: (BuildContext context,HomeController value, Widget? child) {
         final controller=context.read<HomeController>();
         return Scaffold(
             floatingActionButton: FloatingActionButton.extended(
               onPressed: ()async{
                 final bool? result =await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AddTaskScreen()));
                 if (result==true&&result!=null){
                   controller.loadTasks();
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
                                 backgroundImage: value.userImage==null?
                                 AssetImage("assets/images/person.png"):
                                 FileImage(File(value.userImage!)),
                                 backgroundColor: Colors.transparent,
                               ),
                               SizedBox(width:8 ,),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                       "Good Evening ,${value.username} ",
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
                           AchievedTasksWidget(totalTasks:value.totalTasks, doneTasks: controller.doneTasks, percent: value.percent,),
                           SizedBox(height: 8,),
                           HighPriorityTasks( onChanged: (bool? value, int? index) {
                             controller.doneTask(value, index);
                           }, tasks: value.tasks, loadTask:(){controller.loadTasks();},),
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
                       tasks: value.tasks,
                       emptyMessage: 'NO Data',
                       onChanged: (bool? value, int? index) {
                         controller.doneTask(value, index);
                       }, onDeleteSelect: (int? id) {
                       controller.deleteTask(id);
                     }, onEdit: (){
                       controller.loadTasks();
                     },),

                   ],
                 ),
               ),
             )
         );
        },
      ),
    );
  }
}
