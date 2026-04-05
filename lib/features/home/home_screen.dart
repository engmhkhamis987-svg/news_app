import 'package:flutter/material.dart';
import 'package:news_app/features/home/components/category_list.dart';
import 'package:news_app/features/home/components/trending%20_news.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController controller, Widget? child) {
          return Scaffold(
            body: Column(
              children: [
                TrendingNews(),
                ViewAllComponent(title: 'Categories', titleColor: Color(0XFF141414), onTap: () {}),
                CategoryList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
