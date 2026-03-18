import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/functions/push.dart';
import 'package:taskati/core/services/shered_pref.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/features/add_task/page/add_task_page.dart';
import 'package:taskati/features/home/widgets/daily_progress.dart';
import 'package:taskati/features/home/widgets/home_date_picker.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/tasks_builder.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  String imagePath = '';

  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    name = SheredPref.getString('name') ?? '';
    imagePath = SheredPref.getString('imagePath') ?? '';
    setState(() {});
  }

  String selectedDate = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              HomeHeader(imagePath: imagePath, name: name),

              Gap(23),

              DailyProgress(),
              Gap(25),

              HomeDatePicker(
                onDateChange: (date) {
                  selectedDate = date.toString();
                },
              ),
              Gap(20),

              TasksBuilder(selectedDate: selectedDate),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushTo(context, AddTaskPage());
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
