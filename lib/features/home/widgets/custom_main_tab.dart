import 'package:flutter/material.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class CustomMainTab extends StatelessWidget {
  const CustomMainTab({
    super.key,
    required this.isSelected,
    required this.text,
  });

  final String text;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        width: double.infinity,
        height: 45,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected! ? AppColors.primaryColor : AppColors.accentColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyles.caption1.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected! ? Colors.white : AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
