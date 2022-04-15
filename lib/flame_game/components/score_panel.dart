import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScorePanel extends TextComponent {
  late int points = 0;
  Vector2 gameSize;

  ScorePanel(this.gameSize) {
    text = 'Очки : $points';
    size = Vector2(gameSize.x * 0.8, gameSize.y * 0.05);
    x = gameSize.x * 0.1;
    y = gameSize.y * 0.16;
    anchor = Anchor.topLeft;

    textRenderer = TextPaint(
      style: TextStyle(color: Colors.black, fontSize: gameSize.y * 0.03),
    );
  }

  setPoint(int point) {
    if (point < 0 && points <= 0) return;
    this.points += point;
    text = 'Очки : $points';
  }

  reset() {
    points = 0;
    text = 'Очки : $points';
  }
}
