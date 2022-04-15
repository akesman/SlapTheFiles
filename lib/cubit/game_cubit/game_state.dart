part of 'game_cubit.dart';

@immutable
abstract class GameState extends Equatable {}

class GameInitialState extends GameState {
  @override
  List<Object?> get props => [];
}

class LoadingScreenState extends GameState {
  @override
  List<Object?> get props => [];
}

class StartScreenState extends GameState {
  @override
  List<Object?> get props => [1];
}

class GameScreenState extends GameState {
  final User user;

  GameScreenState(this.user);

  @override
  List<Object?> get props => [user];
}

class EndScreenState extends GameState {
  EndScreenState();

  @override
  List<Object?> get props => [];
}
