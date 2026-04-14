import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/core/repos/news_repositry.dart';

class HomeController extends ChangeNotifier with SafeNotify {
  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlinesStatus = RequestStatusEnum.loading;

  List<NewsArticleModel> newsTopHeadlinesList = [];
  List<NewsArticleModel> newsEveryThingList = [];
  BaseNewsRepositry newsRepositry;
  String? errorMessage;
  String selectedCategory = 'business';

  HomeController(this.newsRepositry) {
    getTopHeadlines();
    getEveryThing();
  }

  void getTopHeadlines() async {
    topHeadlinesStatus = RequestStatusEnum.loading;
    try {
      newsTopHeadlinesList = await newsRepositry.getTopHeadlines(selectedCategory: selectedCategory);

      topHeadlinesStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      topHeadlinesStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void getEveryThing() async {
    try {
      newsEveryThingList = await newsRepositry.getEveryThing();
      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void updateCategory(String category) {
    selectedCategory = category;
    getTopHeadlines();
    safeNotify();
  }
}
