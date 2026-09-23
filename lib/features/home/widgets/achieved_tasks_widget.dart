import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app_last_thing/features/home/home_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context,HomeController controller, Widget? child) {
        return Container(
          height:75,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
          decoration: BoxDecoration(
              color:Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Achieved Tasks",
                      style:Theme.of(context).textTheme.titleMedium
                  ),
                  Text(
                      "${controller.doneTasks} Out of ${controller.totalTasks} Done",
                      style:Theme.of(context).textTheme.bodyMedium

                  )

                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi/2,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: CircularProgressIndicator(
                        value: controller.percent,
                        backgroundColor: Color(0xff6D6D6D),
                        valueColor: AlwaysStoppedAnimation(Color(0xff15B86C)),
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                  Text("${(controller.percent*100).toInt()} %",style: Theme.of(context).textTheme.labelSmall)
                ],
              )
            ],
          ),
        );
      },

    );
  }
}
