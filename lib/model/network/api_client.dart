// ignore_for_file: avoid_print, unused_element

import 'package:http/http.dart' as http;

abstract class Client {
  Future<http.Response> getAddressFromZip(String zipCode);

  Future<http.Response> getZenn(String query);
}

class ApiClient implements Client {
  final _timeout = const Duration(seconds: 30);

  Future<http.Response> _get(
    String url,
    Map<String, String?> params,
    bool withToken, {
    Map<String, List<dynamic>>? listParam,
    bool allowEmpty = false,
  }) async {
    try {
      final client = http.Client();
      var requestUrl = url;
      if (params.keys.isNotEmpty) {
        requestUrl = _addParamToUrl(url, params, allowEmpty: allowEmpty);
        if (listParam != null) {
          requestUrl = _addListParamToUrl(
            requestUrl,
            listParam.keys.first.toString(),
            listParam.values.first,
          );
        }
      }

      print('request url: $requestUrl');
      final response = await client
          .get(
            Uri.parse(requestUrl),
          )
          .timeout(_timeout);
      print('response: statusCode=${response.statusCode}, body=${response.body}');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> _post(String url, body, bool withToken) async {
    try {
      final client = http.Client();
      final requestUrl = Uri.parse(url);
      print('request url: $requestUrl');
      final headers = await _getHeaders();
      final response = await client
          .post(
            requestUrl,
            headers: headers,
            body: body,
          )
          .timeout(_timeout);

      print('request body: $body');
      print('response: statusCode=${response.statusCode}, body=${response.body}');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> _put(String url, body, bool withToken) async {
    try {
      final client = http.Client();
      final requestUrl = Uri.parse(url);
      print('request url: $requestUrl');
      final headers = await _getHeaders();
      final response = await client
          .put(
            requestUrl,
            headers: headers,
            body: body,
          )
          .timeout(_timeout);

      print('request body: $body');
      print('response: statusCode=${response.statusCode}, body=${response.body}');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> _delete(
    String url,
    Map<String, String?> params,
    bool withToken, {
    Map<String, List<dynamic>>? listParam,
  }) async {
    try {
      final client = http.Client();
      var requestUrl = url;
      print('request url: $requestUrl');
      if (params.keys.isNotEmpty) {
        requestUrl = _addParamToUrl(url, params);
        if (listParam != null) {
          requestUrl = _addListParamToUrl(
            requestUrl,
            listParam.keys.first.toString(),
            listParam.values.first,
          );
        }
      }

      final response = await client
          .delete(
            Uri.parse(requestUrl),
          )
          .timeout(_timeout);
      print('response: statusCode=${response.statusCode}, body=${response.body}');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final headers = {
      'Content-type': 'application/json',
    };
    return headers;
  }

  static String _addListParamToUrl(
    String base,
    String title,
    List<dynamic> items,
  ) {
    var result = base;
    for (final item in items) {
      // ignore: use_string_buffers
      result += '&$title=$item';
    }
    print(result.toString());
    return result;
  }

  static String _addParamToUrl(String base, Map<String, String?> params, {bool allowEmpty = false}) {
    var result = base;
    result += '?';
    params.forEach((key, value) {
      if (value != null && (value.isNotEmpty || allowEmpty)) {
        result += '$key=$value&';
      }
    });
    final res = result.substring(0, result.length - 1);
    return res;
  }

  @override
  Future<http.Response> getAddressFromZip(String zipCode) async {
    const baseUrl = 'https://zipcloud.ibsnet.co.jp/api/search';
    final params = <String, String>{'zipcode': zipCode.toString(), 'limit': '1'};
    return await _get(baseUrl, params, false);
  }

  @override
  Future<http.Response> getZenn(String query) async {
    const baseUrl = 'https://zenn.dev/api/articles?order=daily&topicname=flutter&count=10&page=1';
    final params = <String, String>{};
    return await _get(baseUrl, params, false);
  }
}
