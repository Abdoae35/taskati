import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/developer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 8, minute: 0);

  // ── date picker ──────────────────────────────────────────
  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  // ── time picker ──────────────────────────────────────────
  Future<TimeOfDay?> pickTime(TimeOfDay initial) async {
    return await showTimePicker(context: context, initialTime: initial);
  }

  String formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]}, ${date.year}';
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SvgPicture.asset(AppAssets.backSvg, height: 24, width: 24),
          ),
        ),
        title: const Text(
          'Add Task',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10),

            // ── Title ────────────────────────────────────────
            CustomTextField(
              hint: '',
              label: 'Title',
              controller: titleController,
            ),
            Gap(20),

            // ── Description ──────────────────────────────────
            CustomTextField(
              hint: '',
              label: 'Description',
              controller: descriptionController,
              maxLines: 4,
            ),
            Gap(30),

            // ── Date ─────────────────────────────────────────
            _PickerTile(
              icon: SvgPicture.asset(AppAssets.calendarSvg),
              iconColor: AppColors.primaryColor,
              label: 'Date',
              value: formatDate(selectedDate),
              onTap: pickDate,
            ),
            Gap(16),

            // ── Start Time ───────────────────────────────────
            _PickerTile(
              icon: SvgPicture.asset(AppAssets.timeSvg),
              iconColor: AppColors.primaryColor,
              label: 'Start Time',
              value: formatTime(startTime),
              onTap: () async {
                final t = await pickTime(startTime);
                if (t != null) setState(() => startTime = t);
              },
            ),
            Gap(16),

            // ── End Time ─────────────────────────────────────
            _PickerTile(
              icon: SvgPicture.asset(AppAssets.timeSvg),
              iconColor: AppColors.primaryColor,
              label: 'End Time',
              value: formatTime(endTime),
              onTap: () async {
                final t = await pickTime(endTime);
                if (t != null) setState(() => endTime = t);
              },
            ),
          ],
        ),
      ),

      // ── Add Task Button ───────────────────────────────────
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 5, 22, 25),
        child: MainButton(
          text: 'Add Task',
          onPressed: () {
            String key =
                DateTime.now().millisecondsSinceEpoch.toString() +
                titleController.text;
            HiveHelper.cacheTask(
              key,
              TaskModel(
                id: key,
                title: titleController.text,
                description: descriptionController.text,
                date: formatDate(selectedDate), // ✅ String
                startTime: formatTime(startTime), // ✅ String
                endTime: formatTime(endTime),
                isCompleted: false,
              ),
            );
            //   log(HiveHelper.taskBox.values.length.toString());
          },
        ),
      ),
    );
  }
}

// ── Reusable picker tile ──────────────────────────────────────
class _PickerTile extends StatelessWidget {
  final SvgPicture icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _PickerTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // icon badge
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Center(child: icon),
            ),
            const Gap(12),
            // label + value
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // dropdown arrow
            SvgPicture.asset(AppAssets.arrowDownSvg, height: 16, width: 16),
          ],
        ),
      ),
    );
  }
}
