import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/model/bloc/page1_bloc.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late Page1Bloc bloc;

  @override
  void initState() {
    // 1回だけ実行されます
    super.initState();

    bloc = BlocProvider.of<Page1Bloc>(context);

    registerListener();
  }

  void registerListener() {
    bloc.err.listen((value) async {
      if (value.isEmpty) {
        return;
      }

      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("えらー"),
            content: Text(value),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // もどる で とじる
                  Navigator.of(context).pop();
                },
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
        title: const Text("Page1たいとる"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.increment();
        },
      ),
      body: StreamBuilder<int>(
        stream: bloc.countStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Text("すとりーむかうんと ${snapshot.data}");
        },
      ),
    );
  }
}
