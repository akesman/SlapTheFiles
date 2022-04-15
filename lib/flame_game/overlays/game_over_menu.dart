import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick/flame_game/flame_game.dart';
import 'package:kick/flame_game/overlays/pause_button.dart';

import '../../cubit/game_cubit/game_cubit.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOverMenu';
  final SFgame gameRef;

  const GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pause menu title.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.green,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
              ),
            ),

            // Restart button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(GameOverMenu.ID);
                  gameRef.overlays.add(PauseButton.ID);
                  gameRef.restart();
                  gameRef.resumeEngine();
                },
                child: Text('Restart'),
              ),
            ),

            // Exit button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(GameOverMenu.ID);
                  gameRef.restart();

                  BlocProvider.of<GameCubit>(context).exitGame();
                },
                child: Text('Exit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
