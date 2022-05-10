import 'dart:async';
import 'dart:convert';

import 'package:board_buff/model/entity/article/article.dart';
import 'package:board_buff/model/network/api_client.dart';

abstract class ZennRepositoryInterface {
  Future<List<Article>> getZenn(String query);
}

class ZennRepository implements ZennRepositoryInterface {
  final Client _client;

  ZennRepository({
    required Client client,
  }) : _client = client;

  @override
  Future<List<Article>> getZenn(String query) async {
    try {
      final response = await _client.getZenn("");
      final jsonResponse = json.decode(response.body);
      final jsonArticles = jsonResponse['articles'] as List;
      final articles = jsonArticles.whereType<Map<String, dynamic>>().map((e) => Article.fromJson(e)).toList();
      return articles;
    } catch (e) {
      rethrow;
    }
  }
}
