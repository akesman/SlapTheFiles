import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class ProgressBarIndicator extends Component {
  double maxValue = 1;
  double minValue = 0;
  double value;
  Vector2 size;

  double _time = 0;

  Paint paint = Paint();
  Paint paintValue = Paint();
  Rect? bgRect;
  Rect? valueRect;

  Function() callBackTimeOver;

  ProgressBarIndicator(this.callBackTimeOver, this.size, {this.value = 1});

  late double dx;
  late double dy;
  late double sizeLine;
  late double sizeH;

  @override
  Future<void>? onLoad() {
    paint.color = Colors.white;
    paintValue.color = Colors.red;

    dx = size.x * .1;
    dy = size.y * .1;
    sizeLine = size.x * 0.8;
    sizeH = size.y * 0.05;

    bgRect = Rect.fromLTWH(dx, dy, sizeLine, sizeH);
    valueRect = Rect.fromLTWH(dx, dy, sizeLine, sizeH);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(bgRect!, paint);
    canvas.drawRect(valueRect!, paintValue);

    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (value <= 0) {
      callBackTimeOver();
      return;
    }
    if (_time > 1) {
      _time = 0;
      value -= 0.003;
      valueRect = Rect.fromLTWH(dx, dy, sizeLine * value, sizeH);
    }
    _time++;
  }

  addTime() {
    value += 0.01;
  }

  loseTime() {
    value -= 0.01;
  }
}
