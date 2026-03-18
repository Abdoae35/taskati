import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/features/complete_profile/page/profile_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.imagePath, required this.name});

  final String imagePath;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            pushTo(context, ProfileScreen());
          },
          child: ClipOval(
            child: imagePath.isNotEmpty
                ? Image.file(
                    File(imagePath),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AppAssets.user,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Gap(15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFonts.lexend,
                ),
              ),
              Gap(0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.lexend,
                ),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () {
            bool isDark = HiveHelper.getCachedThemeMode();
            HiveHelper.cacheThemeMode(!isDark);
          },
          icon: Icon(Icons.dark_mode),
        ),
      ],
    );
  }
}
