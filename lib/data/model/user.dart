class User {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        name: json['name'] as String,
      );
}
