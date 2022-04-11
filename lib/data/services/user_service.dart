import 'package:kick/data/api/user_api.dart';
import 'package:kick/data/models/user.dart';
import 'package:logger/logger.dart';

class UserService {
  final Logger log = Logger(printer: SimplePrinter());

  final UserApi userApi;

  UserService(this.userApi);

  Future<void> addUser(User user) async {
    log.d("Event: addUser");
    if (user == null) return;
    final json = User.userToJson(user);

    if (await userApi.addUser(json)) {
      log.d("Event: addUser well done");
    } else {
      log.d("Event: addUser ERROR!");
    }
  }

  Future<List<User>> getUsers() async {
    log.d("Event: getUsers");
    final userList = await userApi.getUsers();

    if (userList == null || userList.isEmpty) {
      log.d("Event: load empty users");
      return [];
    }

    log.d("Event: load ${userList.length} users");

    List<User> res = [];
    for (final json in userList) {
      res.add(User.jsonToUser(json));
    }

    return res;
  }
}
