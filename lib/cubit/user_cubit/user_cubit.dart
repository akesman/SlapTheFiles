import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:kick/data/models/user.dart';
import 'package:kick/data/services/user_service.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  late UserService _userService;

  User? _currentUser = User();
  List<User> userList = [];

  UserCubit(BuildContext context) : super(UserInitialState()) {
    _userService = Provider.of<UserService>(context, listen: false);
  }

  Future<void> reloadUsers() async {
    userList = await _userService.getUsers();
    emit(UserLoadingState());
    emit(UserLoadState(userList));
  }

  Future<void> addUser(User user) async {
    _currentUser = await _userService.addUser(user);
    await reloadUsers();
  }

  User? get currentUser => _currentUser;

  set setCurrentUser(User? value) {
    _currentUser = value;
  }
}
