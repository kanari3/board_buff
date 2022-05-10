import 'dart:async';
import 'dart:convert';

import 'package:board_buff/model/entity/zenn/zenn.dart';
import 'package:board_buff/model/network/api_client.dart';

abstract class ZennRepositoryInterface {
  Future<Zenn> getZenn({required int page});
}

class ZennRepository implements ZennRepositoryInterface {
  final Client _client;

  ZennRepository({
    required Client client,
  }) : _client = client;

  @override
  Future<Zenn> getZenn({required int page}) async {
    try {
      final response = await _client.getZenn(page: page);
      final jsonResponse = json.decode(response.body);
      // final jsonArticles = jsonResponse['articles'] as List;
      // final articles = jsonArticles.whereType<Map<String, dynamic>>().map(Article.fromJson).toList();
      return Zenn.fromJson(jsonResponse);
    } catch (e) {
      rethrow;
    }
  }
}
