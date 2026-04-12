import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custome_svg_picture.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final NewsArticleModel model;
  @override
  Widget build(BuildContext context) {
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
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0XFF141414)),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              model.publishedAt.formatDateTime(),
                              style: TextStyle(fontSize: 12, color: Color(0XFF141414)),
                            ),
                          ),
                          CustomSvgPicture.withoutColorFilter(path: 'assets/images/bookmark.svg'),
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
  }
}
