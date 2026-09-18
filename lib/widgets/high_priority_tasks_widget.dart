import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';
import 'package:tasky_app_last_thing/screens/high_priority_screen.dart';
import 'package:tasky_app_last_thing/themes/theme_controller.dart';
import 'package:tasky_app_last_thing/widgets/custom_checkBox_widget.dart';

class HighPriorityTasks extends StatelessWidget {
  const HighPriorityTasks({super.key,  required this.onChanged, required this.tasks, required this.loadTask});
final List<TaskModel>tasks;
  final Function (bool? value,int? index)onChanged;
  final Function loadTask;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "High Priority Tasks",
            style:TextStyle(
                color: Color(0xff15B86C),
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),
          ),
          SizedBox(height: 14,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             Expanded(
               child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: tasks.reversed.where((e)=>e.isHighPriority==true).length > 4 ? 4: tasks.reversed.where((e)=>e.isHighPriority==true).length,
                        itemBuilder: (BuildContext context,int index){
                          final task = tasks.reversed.where((e)=>e.isHighPriority==true).toList()[index];
                        return  Row(
                          children: [
                            CustomCheckboxWidget(
                                value: task.isChecked,
                                 onChanged: (bool? value){
                            final index = tasks.indexWhere((e)=>e.id==task.id);
                            onChanged(value,index);
                          }
                            ),
                            Expanded(
                              child: Text(
                                task.taskName,
                          style:task.isChecked?Theme.of(context).textTheme.headlineSmall:Theme.of(context).textTheme.titleSmall,
                                maxLines: 1,
                              ),
                            ),

                          ],);
                    })

                  ],
                ),
             ),
             GestureDetector(
               onTap: ()async{
                  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HighPriorityScreen()));
                  loadTask();
               },
               child: Container(
                 padding: EdgeInsets.all(8),
                 height: 56,
                 width: 48,
                 decoration: BoxDecoration(
                   color:Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(color:ThemeController.themeNotifier.value==ThemeMode.dark? Color(0xff6E6E6E):Color(0xffD1DAD6),width: 2),
                   shape: BoxShape.circle

                 ),
                 child: SvgPicture.asset("assets/images/arrow-up-right.svg",height:24 ,width: 24,colorFilter: ColorFilter.mode(ThemeController.themeNotifier.value==ThemeMode.dark?Color(0xffC6C6C6):Color(0xff3A4640), BlendMode.srcIn),),
               ),
             )
           ],
         )
        ],
      ),
    );
  }
}
