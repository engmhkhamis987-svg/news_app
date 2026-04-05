import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/theme/light_theme.dart';
import 'package:news_app/features/main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //''''''''''''''''''''
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'Flutter Demo', theme: lightTheme, home: MainScreen());
  }
}
