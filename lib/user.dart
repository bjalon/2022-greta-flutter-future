class User {
  final String name;
  final String email;
  final int userId;

  User({required this.userId, required this.name, required this.email});

  User.fromJSon(Map<String, dynamic> json)
      : userId = json["id"],
        email = json["email"],
        name = json["name"];
}
