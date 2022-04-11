class User {
  final String ?id;
  final DateTime ?created_at;
  final String name;
  final int point;

  User(
      {this.id,
      this.created_at,
      required this.name,
      required this.point});

  static Map<String, dynamic> userToJson(User user) {
    return {
      "name": user.name,
      "point": user.point,
    };
  }

  static User jsonToUser(Map<String, dynamic> data) {
    return User(
        id: data['id'].toString(),
        created_at: (data['created_at'] != null
            ? DateTime.parse(data['created_at'])
            : null)!,
        name: data['name'],
        point: data['point']);
  }
}
