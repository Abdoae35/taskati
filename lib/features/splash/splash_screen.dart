import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/styles/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AppAssets.logoJson),

            Text(
              'Taskati',
              style: TextStyle(
                fontSize: 24,
                fontFamily: AppFonts.lexend,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(14),

            Text(
              'It’s time to get organized',
              style: TextStyle(
                fontFamily: AppFonts.lexend,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
