import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/components/top_headlines_shimmer.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadlines extends StatelessWidget {
  const TopHeadlines({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, HomeController controller, child) {
        switch (controller.topHeadlinesStatus) {
          case RequestStatusEnum.loading:
            return TopHeadlinesShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(child: Center(child: Text(controller.errorMessage ?? 'An error occurred')));
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadlinesList.length,
              itemBuilder: (context, index) {
                final model = controller.newsTopHeadlinesList[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
