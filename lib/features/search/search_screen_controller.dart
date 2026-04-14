import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/news_repositry.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotify {
  SearchScreenController(this.newsRepositry) {
    // getEveryThing();
  }
  BaseNewsRepositry newsRepositry;
  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  List<NewsArticleModel> newsEveryThingList = [];
  String? errorMessage;
  final TextEditingController searchController = TextEditingController();

  void getEveryThing() async {
    try {
      newsEveryThingList = await newsRepositry.getEveryThing(query: searchController.text);
      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }
}
