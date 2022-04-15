import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelPanel extends TextComponent {
  late int level = 1;
  Vector2 gameSize;

  LevelPanel(this.gameSize) {
    text = 'Уровень : $level';
    size = Vector2(gameSize.x * 0.8, gameSize.y * 0.05);
    x = gameSize.x * 0.1;
    y = gameSize.y * 0.16 + gameSize.y * 0.05;
    anchor = Anchor.topLeft;

    textRenderer = TextPaint(
      style: TextStyle(color: Colors.black, fontSize: gameSize.y * 0.03),
    );
  }

  setLevel(int level) {
    if (level < 0 && level <= 0) return;
    this.level = level;
    text = 'Уровень : $level';
  }

  reset() {
    level = 1;
    text = 'Уровень : $level';
  }
}
