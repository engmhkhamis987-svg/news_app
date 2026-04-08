import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (context, controller, child) {
          return Column(
            children: [
              ViewAllComponent(title: 'Categories', titleColor: Color(0XFF141414), onTap: () {}),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, bottom: 4),
                child: SizedBox(
                  height: 30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = controller.selectedCategory == categories[index];
                      return GestureDetector(
                        onTap: () => controller.updateCategory(categories[index]),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Text(
                                categories[index][0].toUpperCase() + categories[index].substring(1),
                                style: TextStyle(color: Color(0XFF363636), fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              if (isSelected)
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  height: 2,
                                  color: LightColor.primaryColor,
                                ),
                            ],
                          ),
                        ),
                      );
                    },

                    separatorBuilder: (context, index) {
                      return SizedBox(width: 16);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final List<String> categories = ['Business', 'Entertainment', 'General', 'Health', 'Science', 'Sports', 'Technology'];
}
