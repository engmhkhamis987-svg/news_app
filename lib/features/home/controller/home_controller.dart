import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlinesStatus = RequestStatusEnum.loading;

  List<NewsArticleModel> newsTopHeadlinesList = [];
  List<NewsArticleModel> newsEveryThingList = [];
  ApiService apiService = ApiService();
  String? errorMessage;
  String? selectedCategory;

  HomeController() {
    getTopHeadlines();
    getEveryThing();
  }

  void getTopHeadlines() async {
    try {
      Map<String, dynamic> result = await apiService.get(ApiConfig.topHeadlines, params: {'country': 'us'});

      newsTopHeadlinesList = ((result['articles']) as List).map((e) => NewsArticleModel.fromJson(e)).toList();
      topHeadlinesStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      topHeadlinesStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void getEveryThing() async {
    try {
      Map<String, dynamic> result = await apiService.get(ApiConfig.everything, params: {'q': 'bitcoin'});
      newsEveryThingList = ((result['articles']) as List).map((e) => NewsArticleModel.fromJson(e)).toList();
      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void updateCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }
}
