import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_flutter/webview_flutter.dart'as dev;
// web veiw flutter is used to show the wev page in the app only 

class RecipeView extends StatefulWidget {
  String ? url;
  RecipeView({required this.url});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  String ? final_Url;

  @override
  void initState() {
    if(widget.url.toString().contains("http://")){
      final_Url=widget.url.toString().replaceAll("http://", "https://");
    }else{
      final_Url=widget.url.toString();
    }
    super.initState();
  }

  final Completer<WebViewController> controller=Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Flutter Recipe App"),
      ),
      body: Container(
        child:WebView(
          initialUrl: final_Url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            setState(() {
              // when work is completed it refreshes the complete ui 
              controller.complete(webViewController);
            });
          },
        ) ),
      );
    
  }
}