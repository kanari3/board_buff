import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/model/entity/article/article.dart';
import 'package:board_buff/model/network/api_client.dart';
import 'package:board_buff/model/repository/zenn_repository.dart';
import 'package:rxdart/rxdart.dart';

class ZennBloc implements Bloc {
  final _zipRepository = ZennRepository(client: ApiClient());
  var page = 1;

  // エラー通知
  final err = BehaviorSubject<String>.seeded('');

  // 記事
  final _articles = BehaviorSubject<List<Article>>.seeded([]);
  Stream<List<Article>> get articlesStream => _articles.stream;

  // 入力
  final _input = BehaviorSubject<String>.seeded('');
  Sink<String> get inputAction => _input.sink;

  Future<void> _getData(String query) async {
    try {
      final result = await _zipRepository.getZenn(page: page);
      page++;
      final temp = _articles.value + result.articles;
      _articles.add(temp);
    } catch (e) {
      err.add(e.toString());
    }
  }

  Future<void> search() async {
    await _getData(_input.value);
  }

  @override
  void dispose() {
    _articles.close();
    _input.close();
  }
}
