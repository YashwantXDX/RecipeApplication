import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class RecipeView extends StatefulWidget {

  String url;
  RecipeView(this.url);
  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  late  String finalUrl;
  late WebViewController controller;

  @override
  void initState() {
    if(widget.url.toString().contains("http://"))
    {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    }
    else{
      finalUrl = widget.url;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(finalUrl));

    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recipe App"),
      ),
      body: Container(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
