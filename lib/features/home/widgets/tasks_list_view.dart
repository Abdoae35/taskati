import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/add_task/page/add_task_page.dart';
import 'package:taskati/features/home/widgets/task_card.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key, required this.tasks});
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(child: Text('No Task Found'));
    }
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        TaskModel task = tasks[index];
        return Slidable(
          key: UniqueKey(),

          startActionPane: ActionPane(
            motion: const ScrollMotion(),

            dismissible: DismissiblePane(
              onDismissed: () {
                HiveHelper.tasksBox.delete(task.id);
              },
            ),

            children: [
              SlidableAction(
                onPressed: (context) {
                  HiveHelper.tasksBox.delete(task.id);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),

          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: (context) {
                  HiveHelper.cacheTask(
                    task.id ?? '',
                    task.copyWith(isCompleted: true),
                  );
                },
                backgroundColor: const Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.check,
                label: 'Complete',
              ),
              SlidableAction(
                onPressed: (context) {
                  pushTo(context, AddTaskPage(task: task));
                },
                backgroundColor: Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),

          child: TaskCard(task: task),
        );
      },
      separatorBuilder: (context, index) => Gap(12),
    );
  }
}
