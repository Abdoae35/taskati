import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/functions/push.dart';
import 'package:taskati/core/services/shered_pref.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/features/complete_profile/page/complete_profile.dart';
import 'package:taskati/features/home/page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool? isUploaded = SheredPref.getBool(SheredPref.boolKey);
    Future.delayed(const Duration(seconds: 3), () {
      if (isUploaded != true) {
        pushReplaceMent(context, HomePage());
      } else {
        pushReplaceMent(context, CompleteProfile());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
