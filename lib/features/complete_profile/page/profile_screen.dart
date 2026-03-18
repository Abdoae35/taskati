import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/services/shered_pref.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/widgets/custom_svg_picture.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/widgets/tab_button.dart';
import 'package:taskati/features/home/page/home_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String imagePath = '';
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    name = SheredPref.getString('name') ?? '';
    imagePath = SheredPref.getString('imagePath') ?? '';
    nameController.text = name; // ✅ pre-fill name field
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: () => pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SvgPicture.asset(AppAssets.backSvg, height: 10, width: 10),
          ),
        ),
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            const Gap(40),
            Row(
              children: [
                Text(
                  'Profile Image',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.lexend,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
            const Gap(25),

            Stack(
              children: [
                CircleAvatar(
                  radius: 82,
                  backgroundColor: AppColors.backgroundColor,
                  backgroundImage:
                      imagePath
                          .isNotEmpty // ✅ check isNotEmpty
                      ? FileImage(File(imagePath))
                            as ImageProvider // ✅ cast
                      : AssetImage(AppAssets.user),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child:
                      imagePath
                          .isNotEmpty // ✅ check isNotEmpty
                      ? CircleAvatar(
                          backgroundColor: AppColors.backgroundColor,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                imagePath = '';
                              });
                            },
                            child: CustomSvgPicture(path: AppAssets.deleteSvg),
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
            const Gap(40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabButton(
                  text: 'From Camera',
                  onPressed: () async {
                    var image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                    
                      setState(() {
                        imagePath = image.path;
                      });
                    }
                  },
                  width: 150,
                  height: 40,
                ),
                const Gap(12),
                TabButton(
                  text: 'From Gallery',
                  onPressed: () async {
                    var image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      setState(() {
                        imagePath = image.path;
                      });
                    }
                  },
                  width: 150,
                  height: 40,
                ),
              ],
            ),
            const Gap(45),

            CustomTextField(
              hint: 'Enter your Name',
              label: 'Name',
              controller: nameController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 5, 22, 25),
        child: MainButton(
          text: 'Save',
          onPressed: () async {
            if (imagePath.isNotEmpty && nameController.text.isNotEmpty) {
              // ✅ save and navigate
              await SheredPref.setUserInfo(nameController.text, imagePath);
              await SheredPref.setBool(SheredPref.boolKey, true);
              pushTo(context, HomePage());
            } else if (imagePath.isNotEmpty && nameController.text.isEmpty) {
              errorMessage(context, 'Please enter your name');
            } else if (imagePath.isEmpty && nameController.text.isNotEmpty) {
              errorMessage(context, 'Please upload a profile image');
            } else {
              errorMessage(
                context,
                'Please enter your name and upload a profile image',
              );
            }
          },
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorMessage(
    BuildContext context,
    String error,
  ) {
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(error)));
  }
}
