import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/widgets/custom_svg_picture.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/widgets/tab_button.dart';

class CompleteProfile extends StatefulWidget {
  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  String? imagePath;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete Profile')),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Gap(40),
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
            Gap(25),
    
            Stack(
              children: [
                CircleAvatar(
                  radius: 82,
                  backgroundColor: AppColors.backgroundColor,
                  backgroundImage: imagePath != null
                      ? FileImage(File(imagePath!))
                      : AssetImage(AppAssets.user),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: imagePath != null
                      ? CircleAvatar(
                          backgroundColor: AppColors.backgroundColor,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                imagePath = null;
                              });
                            },
                            child: CustomSvgPicture(
                              path: AppAssets.deleteSvg,
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
              ],
            ),
            Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabButton(
                  text: 'From Camera',
                  onPressed: () async {
                    var image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                  },
                  width: 150,
                  height: 40,
                ),
                Gap(12),
    
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
            Gap(45),
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
          text: 'Let\'s Start',
          onPressed: () {
            nameController.text;
            //image uploaded but name is not empty
    
            //image not uploaded but name is not empty
            //image not uploaded and name is empty
            //image uploaded and name is not empty
    
            if (imagePath != null && nameController.text.isNotEmpty) {
              //navigate to home screen
            } else if (imagePath != null && nameController.text.isEmpty) {
              //show dialog to upload image
              ErrorMessage(context, 'Please enter your name');
            } else if (imagePath == null &&
                nameController.text.isNotEmpty) {
              //show dialog to enter name
              ErrorMessage(context, 'Please upload a profile image');
            } else if (imagePath == null && nameController.text.isEmpty) {
              //show dialog to enter name and upload image
              ErrorMessage(
                context,
                'Please enter your name and upload a profile image',
              );
            }
          },
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> ErrorMessage(
    BuildContext context,
    String error,
  ) {
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(error)));
  }
}
