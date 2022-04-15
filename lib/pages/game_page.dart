import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:kick/flame_game/flame_game.dart';
import 'package:kick/flame_game/overlays/pause_button.dart';
import 'package:kick/flame_game/overlays/pause_menu.dart';

import '../flame_game/overlays/game_over_menu.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SFgame(context),
      initialActiveOverlays: [PauseButton.ID],
      overlayBuilderMap: {
        PauseButton.ID: (BuildContext context, SFgame gameRef) => PauseButton(
              gameRef: gameRef,
            ),
        PauseMenu.ID: (BuildContext context, SFgame gameRef) => PauseMenu(
              gameRef: gameRef,
            ),
        GameOverMenu.ID: (BuildContext context, SFgame gameRef) => GameOverMenu(
              gameRef: gameRef,
            ),
      },
    );
  }
}
