import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick/cubit/game_cubit/game_cubit.dart';
import 'package:kick/flame_game/flame_game.dart';
import 'package:kick/flame_game/overlays/pause_button.dart';

class PauseMenu extends StatelessWidget {
  static const String ID = 'PauseMenu';
  final SFgame gameRef;

  const PauseMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/menuBg.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pause menu title.
              Text(
                'Paused',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.green,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
              ),

              // Resume button.
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  onPressed: () {
                    gameRef.resumeEngine();
                    gameRef.overlays.remove(PauseMenu.ID);
                    gameRef.overlays.add(PauseButton.ID);
                  },
                  child: Text('Resume'),
                ),
              ),

              // Restart button.
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  onPressed: () {
                    gameRef.overlays.remove(PauseMenu.ID);
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
                    gameRef.overlays.remove(PauseMenu.ID);
                    gameRef.restart();
                    BlocProvider.of<GameCubit>(context).exitGame();
                  },
                  child: Text('Exit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
