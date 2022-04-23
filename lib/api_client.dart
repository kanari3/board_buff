import 'package:http/http.dart' as http;

abstract class Client {
}

class ApiClient implements Client {

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
          .timeout(const Duration(seconds: 30));
      print(
          'response: statusCode=${response.statusCode}, body=${response.body}');

      return response;
    } catch (e) {
      rethrow;
    }
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
    // print(result.toString());
    return result;
  }

  static String _addParamToUrl(String base, Map<String, String?> params,
      {bool allowEmpty = false}) {
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
}
