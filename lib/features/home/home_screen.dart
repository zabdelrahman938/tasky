import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app_last_thing/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app_last_thing/features/add_task/add_task_controller.dart';
import 'package:tasky_app_last_thing/features/home/home_controller.dart';
import 'package:tasky_app_last_thing/features/add_task/add_task_screen.dart';
import 'package:tasky_app_last_thing/features/home/widgets/achieved_tasks_widget.dart';
import 'package:tasky_app_last_thing/features/home/widgets/high_priority_tasks_widget.dart';
import 'package:tasky_app_last_thing/features/home/widgets/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    //final HomeController controller=context.read<HomeController>();
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context)=>HomeController()..init(),
      child: Scaffold(
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return  FloatingActionButton.extended(
                onPressed: ()async{
                  final bool? result =await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> AddTaskScreen()));
                  if (result==true&&result!=null){
                    context.read<HomeController>().loadTasks();
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
              );
            },

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
                            Selector<HomeController,String?>(
                              builder: (BuildContext context, String?userImage, Widget? child) {
                                return CircleAvatar(
                                  backgroundImage: userImage==null?
                                  AssetImage("assets/images/person.png"):
                                  FileImage(File(userImage)),
                                  backgroundColor: Colors.transparent,
                                );
                              },
                              selector: (BuildContext context, HomeController controller) {
                                return controller.userImage;
                              },

                            ),
                            SizedBox(width:8 ,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Selector<HomeController,String?>(
                                  builder: (BuildContext context,String? username, Widget? child) {
                                    return  Text(
                                        "Good Evening ,$username ",
                                        style: Theme.of(context).textTheme.titleMedium
                                    );
                                  },
                                  selector: (BuildContext context,HomeController controller ) {
                                    return controller.username;
                                  },

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
                        AchievedTasksWidget(),
                        SizedBox(height: 8,),
                        HighPriorityTasks(),
                        SizedBox(height: 16,),
                        Text(
                            "My Tasks",
                            style: Theme.of(context).textTheme.labelLarge
                        ),
                        SizedBox(height: 16,),
                      ],
                    ),
                  ),
                  SliverTaskListWidget(emptyMessage: 'NO Data',),

                ],
              ),
            ),
          )
      ),
    );
  }
}
