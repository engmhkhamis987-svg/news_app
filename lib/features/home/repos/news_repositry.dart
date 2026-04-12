import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

abstract class BaseNewsRepositry {
  Future<List<NewsArticleModel>> getTopHeadlines({String selectedCategory = "general"});
  Future<List<NewsArticleModel>> getEveryThing();
}

class NewsRepositry extends BaseNewsRepositry {
  NewsRepositry(this.apiService);
  final BaseApiService apiService;

  @override
  Future<List<NewsArticleModel>> getTopHeadlines({String selectedCategory = "general"}) async {
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.topHeadlines,
      params: {'country': 'us', 'category': selectedCategory},
    );

    return ((result['articles']) as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }

  @override
  Future<List<NewsArticleModel>> getEveryThing() async {
    Map<String, dynamic> result = await apiService.get(ApiConfig.everything, params: {'q': 'bitcoin'});
    return ((result['articles']) as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }
}

class NewsRepositryMock extends BaseNewsRepositry {
  @override
  Future<List<NewsArticleModel>> getTopHeadlines({String selectedCategory = "general"}) async {
    Map<String, dynamic> result = await ApiService().get(
      ApiConfig.topHeadlines,
      params: {'country': 'us', 'category': selectedCategory},
    );

    return ((result['articles']) as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }

  @override
  Future<List<NewsArticleModel>> getEveryThing() async {
    Map<String, dynamic> result = await ApiService().get(ApiConfig.everything, params: {'q': 'bitcoin'});
    return ((result['articles']) as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }
}
