class Post {
  final String title;
  final String content;
  final int authorId;

  Post({required this.title, required this.content, required this.authorId});

  Post.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        content = json["body"],
        authorId = json["userId"];
}
