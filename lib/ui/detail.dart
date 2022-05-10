import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class ZennDetailScreen extends StatefulWidget {
  String url;

  ZennDetailScreen(this.url, {Key? key}) : super(key: key);

  @override
  ZennDetailScreenState createState() => ZennDetailScreenState();
}

class ZennDetailScreenState extends State<ZennDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zenn記事詳細'),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
