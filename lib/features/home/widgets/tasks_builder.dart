import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/features/home/widgets/custom_main_tab.dart';
import 'package:taskati/features/home/widgets/tasks_list_view.dart';

class TasksBuilder extends StatefulWidget {
  final String selectedDate;
  const TasksBuilder({super.key,required this.selectedDate});

  @override
  State<TasksBuilder> createState() => _TasksBuilderState();
}

class _TasksBuilderState extends State<TasksBuilder> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            indicator: const BoxDecoration(),
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: const EdgeInsets.symmetric(horizontal: 6),
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            indicatorWeight: 0,
            tabs: [
              CustomMainTab(text: 'All', isSelected: _selectedIndex == 0),
              CustomMainTab(
                text: 'In Progress',
                isSelected: _selectedIndex == 1,
              ),
              CustomMainTab(text: 'Completed', isSelected: _selectedIndex == 2),
            ],
          ),

          // ✅ ValueListenableBuilder listens to box changes automatically
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: HiveHelper.tasksBox.listenable(),
              builder: (context, box, _) {
                final allTasks = box.values.toList();
                final inProgress = allTasks
                    .where((t) => t.isCompleted == false)
                    .toList();
                final completed = allTasks
                    .where((t) => t.isCompleted == true)
                    .toList();

                return TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TasksListView(tasks: allTasks),
                    TasksListView(tasks: inProgress),
                    TasksListView(tasks: completed),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
