import 'package:kick/data/api/database_api.dart';

class UserApi {
  final DatabaseApi databaseApi;

  UserApi(this.databaseApi);

  Future<List<dynamic>> getUsers() async {
    final selectData = (await databaseApi
        .getSupabaseClient()
        .from("userG")
        .select("*")
        .order("point", ascending: false)
        .execute());

    return selectData.data;
  }

  Future<bool> addUser(Map<String, dynamic> json) async {
    final insertData = (await databaseApi
        .getSupabaseClient()
        .from("userG")
        .insert(json)
        .execute());

    if (insertData.error == null) return true;
    return false;
  }
}
