import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/images/logo.png', height: 45)),
            const SizedBox(height: 40),
            const Text(
              "Welcome to News App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: emailController,
              title: "Email",
              hintText: "usama@gmail.com",
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: passwordController,
              title: "Password",
              hintText: "**********",
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}
