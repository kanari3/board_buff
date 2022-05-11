import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/model/bloc/favorite_bloc.dart';
import 'package:board_buff/model/entity/article/article.dart';
import 'package:flutter/material.dart';
import 'detail.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late FavoriteBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<FavoriteBloc>(context);
    registerListener();
  }

  void registerListener() {
    bloc.err.listen((value) async {
      if (value.isEmpty) {
        return;
      }

      return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("エラー"),
            content: Text(value),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zennブックマーク一覧'),
        actions: [
          reloadButton(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 10),
          Expanded(
            child: StreamBuilder<List<Article>>(
              stream: bloc.articlesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data?[index];
                      return articleListTile(data);
                    },
                  );
                }
                return const Text('記事なし');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget articleListTile(Article? article) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        margin: const EdgeInsets.only(top: 2, bottom: 2, left: 4, right: 4),
        child: Row(
          children: [
            Text(
              '${article?.emoji}',
              style: const TextStyle(fontSize: 24),
            ),
            Container(width: 10),
            Expanded(
              child: Text(
                '${article?.title}',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateToDetail(article);
      },
    );
  }

  Widget reloadButton() {
    return ElevatedButton(
      onPressed: bloc.reload,
      child: const Icon(Icons.refresh),
    );
  }

  void navigateToDetail(Article? article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ZennDetailScreen(article),
      ),
    );
  }
}
