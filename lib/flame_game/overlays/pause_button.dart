import 'package:flutter/material.dart';
import 'package:kick/flame_game/flame_game.dart';
import 'package:kick/flame_game/overlays/pause_menu.dart';

class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  final SFgame gameRef;

  const PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: MediaQuery.of(context).size.width*0.2,
        width: MediaQuery.of(context).size.width*0.2,
        child: TextButton(
          child: Image.asset(
            "assets/images/stopButton.png"
          ),
          onPressed: () {
            gameRef.pauseEngine();
            gameRef.overlays.add(PauseMenu.ID);
            gameRef.overlays.remove(PauseButton.ID);
          },
        ),
      ),
    );
  }
}
