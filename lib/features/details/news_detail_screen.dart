import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custome_svg_picture.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key, required this.model});
  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Detail')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.r8),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r8),
                child: Image.network(model.urlToImage),
              ),
              SizedBox(height: AppSizes.ph12),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: AppSizes.r20,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF141414),
                ),
              ),
              SizedBox(height: AppSizes.ph8),

              Row(
                children: [
                  CircleAvatar(
                    radius: AppSizes.r16,
                    backgroundImage: NetworkImage(model.urlToImage),
                  ),
                  SizedBox(width: AppSizes.w8),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          model.author.substring(0, min(10, model.author.length)),
                          style: TextStyle(
                            fontSize: AppSizes.sp14,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF141414),
                          ),
                        ),
                        SizedBox(width: AppSizes.w8),
                        Expanded(
                          child: Text(
                            model.publishedAt.formatDateTime(),
                            style: TextStyle(
                              fontSize: AppSizes.sp14,
                              color: Color(0XFF141414),
                            ),
                          ),
                        ),
                        CustomSvgPicture.withoutColorFilter(
                          path: 'assets/images/bookmark.svg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSizes.ph12),
              Text(
                model.description,
                style: TextStyle(
                  fontSize: AppSizes.sp16,
                  color: Color(0XFF141414),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
