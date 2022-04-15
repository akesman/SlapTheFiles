part of 'user_cubit.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadState extends UserState {
  final List<User> userList;

  UserLoadState(this.userList);

  @override
  List<Object> get props => [userList];
}
