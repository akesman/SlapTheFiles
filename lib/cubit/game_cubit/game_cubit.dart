import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kick/data/models/type_screen.dart';
import 'package:kick/data/models/user.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitialState());

  initGame() async {
    await _changeScreen(TypeScreen.startScreen);
  }

  startGame(User user) async {
    await _changeScreen(TypeScreen.gameScreen, user: user);
  }

  _changeScreen(TypeScreen typeScreen, {User? user}) async {
    emit(LoadingScreenState());
    await Future<void>.delayed(const Duration(milliseconds: 20));

    switch (typeScreen) {
      case TypeScreen.startScreen:
        emit(StartScreenState());
        break;
      case TypeScreen.gameScreen:
        emit(GameScreenState(user!));
        break;
    }
  }

  exitGame() async {
    emit(EndScreenState());
    await _changeScreen(TypeScreen.startScreen);
  }
}
