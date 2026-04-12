import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/core/datasource/remote_data/api_config.dart';

abstract class BaseApiService {
  Future<dynamic> get(String endpoint, {Map<String, String>? params});
}

class ApiService extends BaseApiService {
  ///////////////single tone
  // static final ApiService _instance = ApiService._();
  // factory ApiService() => _instance;

  // ApiService._();

  @override
  Future<dynamic> get(String endpoint, {Map<String, String>? params}) async {
    var url = Uri.http(ApiConfig.baseUrl, 'v2/$endpoint', {"apiKey": ApiConfig.apiKey, ...?params});
    try {
      final http.Response response = await http.get(url);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load data:');
    }
  }
}
