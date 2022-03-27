import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web/post.dart';
import 'package:flutter_web/post_fetcher.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(const MainView());
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool isPostShown = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          IconButton(
              onPressed: () => setState(() => isPostShown = true),
              icon: Icon(Icons.upload_file)),
          if (isPostShown) PostFetcher()
        ],
      ),
    ));
  }
}
