import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Market Research',
                style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
              ),
              Gap(7),

              Text(
                'Grocery shopping app design Grocery shopping app design',
                style: TextStyles.caption1.copyWith(
                  color: AppColors.secondaryColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(7),

              Row(
                children: [
                  SvgPicture.asset(AppAssets.timeSvg),
                  Gap(5),
                  Text(
                    '10:00 AM - 11:00 AM',
                    style: TextStyle(color: AppColors.primary50Color),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.accentColor,
                    ),
                    child: Text(
                      'In Progress',
                      style: TextStyles.caption1.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Gap(12);
      },
    );
  }
}
