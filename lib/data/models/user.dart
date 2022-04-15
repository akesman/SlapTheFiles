class User {
  final String? id;
  final DateTime? created_at;
  final String? name;
  final int? point;

  User({this.id, this.created_at, this.name, this.point = 0});

  User merge(User user) {
    return User(
        name: user.name ?? name, point: user.point ?? point, id: user.id ?? id);
    // return User(name: name, point: point, created_at: created_at, id: id);
  }

  static Map<String, dynamic> userToJson(User user) {
    Map<String, dynamic> data = {
      "name": user.name,
      "point": user.point,
    };

    if (user.id != null) {
      data['id'] = user.id;
    }

    return data;
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
