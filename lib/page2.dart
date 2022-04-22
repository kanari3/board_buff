import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/page2_bloc.dart';
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<Page2Bloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('住所検索'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('郵便番号:'),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: const Text('けんさく'),
                ),
              ],
            ),
            Container(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
