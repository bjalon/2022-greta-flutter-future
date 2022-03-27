import 'package:flutter_web/user.dart';

class Post {
  final String title;
  final String content;
  final int authorId;
  User? author;

  Post({required this.title, required this.content, required this.authorId});

  Post.fromJSON(Map<String, dynamic> json)
      : title = json["title"],
        content = json["body"],
        authorId = json["userId"];

  setAuthor(User author) {
    this.author = author;
  }
}
