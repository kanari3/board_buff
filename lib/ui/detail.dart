import 'dart:io';

import 'package:board_buff/model/entity/article/article.dart';
import 'package:board_buff/model/realm/article/article.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class ZennDetailScreen extends StatefulWidget {
  Article? article;

  ZennDetailScreen(this.article, {Key? key}) : super(key: key);

  @override
  ZennDetailScreenState createState() => ZennDetailScreenState();
}

class ZennDetailScreenState extends State<ZennDetailScreen> {
  Realm realm = Realm(Configuration([ArticleModel.schema]));

  final _isFavorite = BehaviorSubject<bool>.seeded(false);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }

    generateUrl();
    getFavoriteStatus();
  }

  String generateUrl() {
    final url = 'https://zenn.dev/${widget.article?.user?.username}/articles/${widget.article?.slug}';
    print('url: $url');
    return url;
  }

  getFavoriteStatus() {
    final favorites = realm.all<ArticleModel>().query("id == '${widget.article?.id}'");
    _isFavorite.add(favorites.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zenn記事詳細'),
        actions: [
          favoriteButton(),
        ],
      ),
      body: WebView(
        initialUrl: generateUrl(),
      ),
    );
  }

  Widget favoriteButton() {
    return StreamBuilder<bool>(
      stream: _isFavorite.stream,
      initialData: false,
      builder: (context, snapshot) {
        final flag = snapshot.data!;
        return ElevatedButton(
          onPressed: () async {
            flag ? delete() : save();
          },
          child: Icon(
            Icons.star,
            color: flag ? Colors.yellow : Colors.white,
          ),
        );
      },
    );
  }

  Future<void> save() async {
    print('保存');
    final item = widget.article;
    final article = ArticleModel(
      id: item?.id,
      emoji: item?.emoji,
      title: item?.title,
      slug: item?.slug,
      username: item?.user?.username,
    );
    realm.write(() {
      realm.add(article);
    });
    _isFavorite.add(true);
  }

  Future<void> delete() async {
    print('削除');
    final items = realm.all<ArticleModel>().query("id == '${widget.article?.id}'");
    realm.write(() {
      realm.deleteMany(items);
    });
    _isFavorite.add(false);
  }
}
