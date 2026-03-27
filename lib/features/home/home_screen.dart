import 'package:flutter/material.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: Consumer(
        builder:
            (BuildContext context, HomeController controller, Widget? child) {
              return Scaffold(
                body: controller.topHeadlinesLoading
                    ? const Center(child: CircularProgressIndicator())
                    : controller.errorMessage?.isNotEmpty ?? false
                    ? Center(child: Text(controller.errorMessage!))
                    : ListView.builder(
                        itemCount: controller.newsTopHeadlinesList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              controller.newsTopHeadlinesList[index].title,
                            ),
                          );
                        },
                      ),
              );
            },
      ),
    );
  }
}
