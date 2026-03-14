import 'dart:io';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/services/shered_pref.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
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

              HomeDatePicker(),
              Gap(20),

              TasksBuilder(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
