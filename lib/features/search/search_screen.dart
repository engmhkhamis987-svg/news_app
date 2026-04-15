import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repos/news_repositry.dart';
import 'package:news_app/features/details/news_detail_screen.dart';
import 'package:news_app/features/search/search_screen_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),

      body: ChangeNotifierProvider(
        create: (context) {
          return SearchScreenController(NewsRepositry(ApiService()));
        },
        child: Padding(
          padding: EdgeInsets.all(AppSizes.r16),
          child: Consumer<SearchScreenController>(
            builder: (context, controller, child) {
              return Column(
                children: [
                  TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.getEveryThing();
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0XFFA0A0A0),
                        size: AppSizes.r30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.newsEveryThingList.length,
                      itemBuilder: (context, index) {
                        final model = controller.newsEveryThingList[index];
                        return ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NewsDetailScreen(model: model),
                            ),
                          ),
                          leading: Icon(
                            Icons.search,
                            color: Color(0XFFA0A0A0),
                            size: AppSizes.r24,
                          ),
                          title: Text(model.title),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          Divider(color: Color(0XFFA0A0A0)),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
