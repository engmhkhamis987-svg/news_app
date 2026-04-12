import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/theme/light_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/main/main_screen.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  await PreferencesManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 830),
      minTextAdapt: true,
      builder: (ctx, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        home: MainScreen(),
      ),
    );
  }
}
