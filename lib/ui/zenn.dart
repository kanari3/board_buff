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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('キーワード'),
              SizedBox(
                width: 150,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: bloc.inputAction.add,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  bloc.search();
                },
                child: const Text('Search'),
              ),
            ],
          ),
          Container(
            height: 50,
          ),
          StreamBuilder<List<Article>>(
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
          )
        ],
      ),
    );
  }

  Widget articleListTile(Article? article) {
    return GestureDetector(
      child: Text('${article?.title}'),
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
