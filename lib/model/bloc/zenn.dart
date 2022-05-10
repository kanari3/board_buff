import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/model/entity/article/article.dart';
import 'package:board_buff/model/network/api_client.dart';
import 'package:board_buff/model/repository/zenn_repository.dart';
import 'package:rxdart/rxdart.dart';

class ZennBloc implements Bloc {
  final _zipRepository = ZennRepository(client: ApiClient());

  // 記事
  final _articles = BehaviorSubject<List<Article>>.seeded([]);
  Stream<List<Article>> get articlesStream => _articles.stream;

  // 入力
  final _input = BehaviorSubject<String>.seeded('');
  Sink<String> get inputAction => _input.sink;

  Future<void> _getData(String query) async {
    final result = await _zipRepository.getZenn(query);
    _articles.add(result);
  }

  Future<void> search() async {
    await _getData(_input.value);
  }

  @override
  void dispose() {
    _articles;
    _input;
  }
}
