import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/model/bloc/zenn.dart';
import 'package:board_buff/model/entity/article/article.dart';
import 'package:flutter/material.dart';
import 'detail.dart';

class Zenn extends StatefulWidget {
  const Zenn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZennState();
}

class _ZennState extends State<Zenn> {
  late ZennBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ZennBloc>(context);
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
            )),
          ],
        ),
      ),
      onTap: () {
        final url = 'https://zenn.dev/${article?.user?.username}/articles/${article?.slug}';
        print('url: $url');
        navigateToDetail(url);
      },
    );
  }

  void navigateToDetail(String url) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ZennDetailScreen(url),
      ),
    );
  }
}
