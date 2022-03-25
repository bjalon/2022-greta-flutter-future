import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web/post.dart';
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
  String? data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          IconButton(
              onPressed: doDownloadButton, icon: const Icon(Icons.download)),
          Text(data ?? "en attente de téléchargement "),
          FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final post = snapshot.data as Post;
                  return Column(
                    children: [
                      Text("Titre: ${post.title}"),
                      Text("Description: ${post.content}"),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const CircularProgressIndicator();
                }
              },
              future: doDownloadFutureBuilder())
        ],
      ),
    ));
  }

  Future<Post> doDownloadFutureBuilder() async {
    // return Future.delayed(const Duration(seconds: 3), () => "Hello world");
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");
    await Future.delayed(const Duration(seconds: 3));
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Post.fromJson(json);
    } else {
      throw Exception("Erreur de téléchargement");
    }
  }

  void doDownloadButton() async {
    Future.delayed(
        const Duration(seconds: 3), () => setState(() => data = "Hello world !"));
  }
}
