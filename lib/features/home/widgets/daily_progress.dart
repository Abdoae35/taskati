import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/app_colors.dart';

class DailyProgress extends StatelessWidget {
  const DailyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveHelper.tasksBox.listenable(),
      builder: (context, box, child) {
        List<TaskModel> completedTask = [];
        for (var task in box.values) {
          if (task.isCompleted == true) {
            completedTask.add(task);
          }
        }
        double completedPercentage = box.values.isEmpty
            ? 0
            : (completedTask.length / box.values.length) * 100;
        return Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 25),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, d MMMM').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.lexend,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                    Gap(13),
                    Text(
                      'Your today\’s task almost done!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.lexend,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ],
                ),

                Gap(35),
                CircularPercentIndicator(
                  backgroundColor: AppColors.primary50Color,
                  startAngle: 130,
                  radius: 35.0,
                  lineWidth: 7.0,
                  percent: completedPercentage / 100,
                  center: new Text(
                    "${completedPercentage.toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.lexend,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  progressColor: AppColors.backgroundColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
