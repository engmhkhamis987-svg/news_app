import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
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
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomCachedNetworkImage(imageUrl: model.urlToImage),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.title,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                CircleAvatar(radius: 10, backgroundImage: NetworkImage(model.urlToImage)),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        model.author.substring(0, min(10, model.author.length)),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0XFF141414),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        model.publishedAt.formatDateTime(),
                                        style: TextStyle(fontSize: 12, color: Color(0XFF141414)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }
}
