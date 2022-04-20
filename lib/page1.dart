import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/page1_bloc.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  late Page1Bloc bloc;

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of<Page1Bloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Page1たいとる"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
      ),
      body: Text("かうんと： ${bloc.countValue}"),
    );
  }
}
