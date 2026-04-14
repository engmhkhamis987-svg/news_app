import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/profile/bottom_sheet/profile_bottom_sheet.dart';
import 'package:news_app/features/profile/profile_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Scaffold(
        appBar: AppBar(title: Text('Profile')),

        body: Consumer<ProfileController>(
          builder: (context, controller, child) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.r16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: AppSizes.r60,
                          backgroundImage: controller.selectedImage != null
                              ? FileImage(File(controller.selectedImage!.path))
                              : AssetImage('assets/images/profile.png'),
                          backgroundColor: Colors.transparent,
                        ),

                        GestureDetector(
                          onTap: () => showImageSourceDialoge(context),
                          child: Container(
                            width: AppSizes.r34,
                            height: AppSizes.r34,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(Icons.camera_alt_outlined, size: AppSizes.r20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.ph8),
                    Text(
                      PreferencesManager().getString('user_name') ?? 'user name',
                      style: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400, color: Color(0xFF161F1B)),
                    ),
                    SizedBox(height: AppSizes.ph24),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Profile Info',
                        style: TextStyle(
                          fontSize: AppSizes.sp14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff161F1B),
                        ),
                      ),
                    ),

                    _buildProfileItem('Personal Info', Icons.person_outline, () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return ProfileBottomSheet();
                        },
                      ).then((_) {
                        controller.getUserName();
                      });
                    }),
                    _buildProfileItem('Language', Icons.language, () {}),
                    _buildProfileItem('Country', Icons.flag_outlined, () {}),
                    _buildProfileItem('Terms & Conditions', Icons.description_outlined, () {}),
                    _buildProfileItem(
                      'Logout',
                      Icons.logout,
                      () async {
                        await PreferencesManager().clear();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                      },
                      haveDivider: false,
                      color: LightColor.primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showImageSourceDialoge(BuildContext context) {
    final controller = context.read<ProfileController>();
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Select Image Source", style: Theme.of(context).textTheme.titleMedium),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: AppSizes.pw16),
                  Text("Camera"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
              child: Row(
                children: [
                  Icon(Icons.camera),
                  SizedBox(width: AppSizes.pw16),
                  Text("Gallary"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileItem(
    String title,
    IconData icon,
    Function() onTap, {
    Color color = const Color(0xFF161F1B),
    bool haveDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: color),
          title: Text(
            title,
            style: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400, color: color),
          ),

          trailing: Icon(Icons.arrow_forward_ios, size: AppSizes.r20, color: color),
        ),
        if (haveDivider) Divider(color: Color(0xffD1DAD6)),
      ],
    );
  }
}
