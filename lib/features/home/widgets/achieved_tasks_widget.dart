import 'dart:math';

import 'package:flutter/material.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key, required this.totalTasks, required this.doneTasks, required this.percent});
  final int totalTasks;
  final int doneTasks;
  final double percent;
  @override
  Widget build(BuildContext context) {
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
                "$doneTasks Out of $totalTasks Done",
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
                       value: percent,
                       backgroundColor: Color(0xff6D6D6D),
                    valueColor: AlwaysStoppedAnimation(Color(0xff15B86C)),
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text("${(percent*100).toInt()} %",style: Theme.of(context).textTheme.labelSmall)
            ],
          )
        ],
      ),
    );
  }
}
