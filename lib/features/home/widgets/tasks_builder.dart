import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/home/widgets/custom_main_tab.dart';
import 'package:taskati/features/home/widgets/tasks_list_view.dart';

class TasksBuilder extends StatefulWidget {
  const TasksBuilder({super.key});

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
            indicator: BoxDecoration(),
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.symmetric(horizontal: 6),
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
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [TasksListView(), TasksListView(), TasksListView()],
            ),
          ),
        ],
      ),
    );
  }
}
