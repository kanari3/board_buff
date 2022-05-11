import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/model/entity/article/article.dart';
import 'package:board_buff/model/entity/user/user.dart';
import 'package:board_buff/model/realm/article/article.dart';
import 'package:realm/realm.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteBloc implements Bloc {
  FavoriteBloc() {
    _getData();
  }
  Realm realm = Realm(Configuration([ArticleModel.schema]));

  // エラー通知
  final err = BehaviorSubject<String>.seeded('');

  // 記事
  final _articles = BehaviorSubject<List<Article>>.seeded([]);
  Stream<List<Article>> get articlesStream => _articles.stream;

  Future<void> _getData() async {
    try {
      final favorites = realm.all<ArticleModel>();
      List<Article> articles = [];
      favorites.map((e) {
        final article = Article(
          id: e.id,
          emoji: e.emoji,
          title: e.title,
          slug: e.slug,
          user: User(username: e.username),
        );
        articles.add(article);
      }).toList();
      _articles.add(articles);
    } catch (e) {
      err.add(e.toString());
    }
  }

  @override
  void dispose() {
    _articles.close();
  }
}
