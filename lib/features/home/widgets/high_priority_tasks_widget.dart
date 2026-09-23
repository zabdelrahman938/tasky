import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app_last_thing/core/themes/theme_controller.dart';
import 'package:tasky_app_last_thing/core/widgets/custom_checkBox_widget.dart';
import 'package:tasky_app_last_thing/features/home/home_controller.dart';
import 'package:tasky_app_last_thing/models/task_model.dart';
import 'package:tasky_app_last_thing/features/tasks/high_priority_screen.dart';

class HighPriorityTasks extends StatelessWidget {
  const HighPriorityTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
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
                            itemCount: controller.tasks.reversed.where((e)=>e.isHighPriority==true).length > 4 ? 4: controller.tasks.reversed.where((e)=>e.isHighPriority==true).length,
                            itemBuilder: (BuildContext context,int index){
                              final task = controller.tasks.reversed.where((e)=>e.isHighPriority==true).toList()[index];
                              return  Row(
                                children: [
                                  CustomCheckboxWidget(
                                      value: task.isChecked,
                                      onChanged: (bool? value){
                                        final index = controller.tasks.indexWhere((e)=>e.id==task.id);
                                        controller.doneTask(value, index);
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
                     controller.loadTasks();
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
      },

    );
  }
}
