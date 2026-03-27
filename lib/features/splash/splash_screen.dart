import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/features/login/login_screen.dart';
import 'package:news_app/features/main/main_screen.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateAfterSplash();
    super.initState();
  }

  void _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));

    final onboardingComplete =
        PreferencesManager().getBool('onboarding_completed') ?? false;
    final isLoggedIn = PreferencesManager().getBool('is_logged_in') ?? false;

    if (!mounted) return;
    if (!onboardingComplete) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else if (!isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.png',
        fit: BoxFit.fill,
        width: double.infinity,
      ),
    );
  }
}
