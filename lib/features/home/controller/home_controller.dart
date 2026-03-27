import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  bool topHeadlinesLoading = true;
  bool everyThingLoading = true;
  List<NewsArticleModel> newsTopHeadlinesList = [];
  List<NewsArticleModel> newsEveryThingList = [];
  ApiService apiService = ApiService();
  String? errorMessage;

  HomeController() {
    getTopHeadlines();
    getEveryThing();
  }

  void getTopHeadlines() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {'country': 'us'},
      );

      newsTopHeadlinesList = ((result['articles']) as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      topHeadlinesLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadlinesLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void getEveryThing() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.everything,
        params: {'q': 'bitcoin'},
      );
      newsEveryThingList = ((result['articles']) as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      everyThingLoading = false;
      errorMessage = null;
    } catch (e) {
      everyThingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
