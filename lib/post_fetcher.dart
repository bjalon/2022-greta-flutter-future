import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web/post.dart';
import 'package:flutter_web/user.dart';
import 'package:http/http.dart' as http;

class PostFetcher extends StatelessWidget {
  const PostFetcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> children = [];
            for (var post in snapshot.data!) {
              Widget widget = Column(children: [
                Text("Title: ${post.title}"),
                Text("Content: ${post.content}"),
                Text("Author: ${post.author!.name}"),
              ]);
              children.add(widget);
            }

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: children,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Une erreur s'est produite");
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<List<Post>> fetchPosts() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    http.Response response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception("Probl¡èmedfsdk");
    }
    print("hi ${response.body}");
    List<dynamic> json = jsonDecode(response.body);
    final List<Post> posts = [];
    for (var jsonPost in json) {
      final post = Post.fromJSON(jsonPost);
      final author = await fetchUser(post.authorId);
      post.setAuthor(author);
      posts.add(post);
    }
    return posts;
    // return Future.delayed(Duration(seconds: 3), () => "Bonjour tout le monde");
  }

  Future<Post> fetchBlog(int id) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$id");
    http.Response response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception("Probl¡èmedfsdk");
    }
    Map<String, dynamic> json = jsonDecode(response.body);

    final post = Post.fromJSON(json);
    final author = await fetchUser(post.authorId);
    post.setAuthor(author);
    return post;
    // return Future.delayed(Duration(seconds: 3), () => "Bonjour tout le monde");
  }

  Future<User> fetchUser(int userId) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/users/$userId");
    http.Response response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception("Probl¡èmedfsdk");
    }
    Map<String, dynamic> json = jsonDecode(response.body);
    print("JSON: ${json}");
    return User.fromJSon(json);
  }
}
