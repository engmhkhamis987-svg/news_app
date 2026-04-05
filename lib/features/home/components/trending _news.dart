import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset('assets/images/background_img.png', fit: BoxFit.fill),
          ),
          Positioned.fill(
            top: 60,
            child: Column(
              children: [
                Text(
                  'NEWST',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: LightColor.primaryColor),
                ),
                SizedBox(height: 6),
                ViewAllComponent(title: 'Trending News', onTap: () {}),
                SizedBox(height: 12),
                SizedBox(
                  height: 140,
                  child: Consumer<HomeController>(
                    builder: (context, HomeController controller, child) {
                      switch (controller.everyThingStatus) {
                        case RequestStatusEnum.loading:
                          return const Center(child: CircularProgressIndicator());
                        case RequestStatusEnum.error:
                          return Center(child: Text(controller.errorMessage ?? 'An error occurred'));
                        case RequestStatusEnum.loaded:
                          return ListView.separated(
                            padding: const EdgeInsets.only(left: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.newsEveryThingList.take(6).length,
                            separatorBuilder: (context, index) => SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final model = controller.newsEveryThingList[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    Image.network(model.urlToImage, width: 240),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withValues(alpha: 0.5),
                                              Colors.black.withValues(alpha: 0.7),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 12,
                                      right: 12,
                                      bottom: 12,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.title,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffFFFCFC),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 6),
                                          Row(
                                            children: [
                                              CircleAvatar(backgroundImage: NetworkImage(model.urlToImage), radius: 12),
                                              SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  model.author,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xffFFFCFC),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                formatDateTime(model.publishedAt),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffFFFCFC),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(String date) {
    if (date.isEmpty) return '';
    final diff = DateTime.now().difference(DateTime.parse(date));
    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    return '${diff.inDays} days ago';
  }
}
