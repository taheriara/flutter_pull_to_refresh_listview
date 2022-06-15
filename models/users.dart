class User {
  final int userId;
  final int id;
  final String title;

  const User({
    required this.userId,
    required this.id,
    required this.title,
  });

  static User fromJson(json) => User(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
      );
}
