import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Page1たいとる"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
      ),
      body: const Text("こんてんつ"),
    );
  }
}
