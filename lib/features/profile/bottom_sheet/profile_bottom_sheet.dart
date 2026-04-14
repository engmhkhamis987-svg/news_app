import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  final TextEditingController usreNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    usreNameController.text = PreferencesManager().getString('user_name') ?? "";
    emailController.text = PreferencesManager().getString('user_email') ?? "";
  }

  void _saveUserData() async {
    if (formKey.currentState!.validate()) {
      await PreferencesManager().setString('user_name', usreNameController.text);
      await PreferencesManager().setString('user_email', emailController.text);
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.r16),
          topRight: Radius.circular(AppSizes.r16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: AppSizes.w24,
                  height: AppSizes.h4,
                  decoration: BoxDecoration(color: Color(0xFF363636), borderRadius: BorderRadius.circular(100)),
                ),
              ),
              SizedBox(height: AppSizes.ph16),
              Text(
                'Profile Info',
                style: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400, color: Color(0xFF141414)),
              ),
              SizedBox(height: AppSizes.ph24),
              CustomTextFormField(
                controller: usreNameController,
                title: "Username",
                hintText: "usama",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }

                  return null;
                },
              ),
              SizedBox(height: AppSizes.ph16),
              CustomTextFormField(
                controller: emailController,
                title: "Email",
                hintText: "usama@gmail.com",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  _saveUserData();
                },
                child: Text('Save'),
              ),
              SizedBox(height: AppSizes.ph16),
            ],
          ),
        ),
      ),
    );
  }
}
