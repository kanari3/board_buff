import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/model/bloc/page2_bloc.dart';
import 'package:board_buff/model/bloc/zenn.dart';
import 'package:board_buff/ui/page1.dart';
import 'package:board_buff/ui/page2.dart';
import 'package:board_buff/ui/zenn.dart';
import 'package:flutter/material.dart';

import '../model/bloc/page1_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              child: const Text("すとりーむさんぷる"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      creator: (context, _) => Page1Bloc(),
                      child: const Page1(),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text("つうしんさんぷる"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      creator: (context, _) => Page2Bloc(),
                      child: const Page2(),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Zenn"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      creator: (context, _) => ZennBloc(),
                      child: const Zenn(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
