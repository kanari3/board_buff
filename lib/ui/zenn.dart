import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/model/bloc/zenn.dart';
import 'package:board_buff/model/entity/article/article.dart';
import 'package:flutter/material.dart';
import 'detail.dart';
import 'package:loadmore/loadmore.dart';

class ZennList extends StatefulWidget {
  const ZennList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZennListState();
}

class _ZennListState extends State<ZennList> {
  late ZennBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ZennBloc>(context);
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
        title: const Text('Zenn記事検索'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('キーワード'),
                Expanded(
                    child: SizedBox(
                  width: 150,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: bloc.inputAction.add,
                  ),
                )),
                ElevatedButton(
                  onPressed: () {
                    bloc.search();
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          Container(height: 10),
          Expanded(
            child: StreamBuilder<List<Article>>(
              stream: bloc.articlesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return LoadMore(
                    textBuilder: DefaultLoadMoreTextBuilder.english,
                    onLoadMore: _loadMore,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data?[index];
                        return articleListTile(data);
                      },
                    ),
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

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(const Duration(seconds: 0, milliseconds: 100));
    await bloc.search();
    return true;
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

  void navigateToDetail(Article? article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ZennDetailScreen(article),
      ),
    );
  }
}
