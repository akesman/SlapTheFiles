import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:kick/flame_game/components/fiel.dart';
import 'package:kick/flame_game/manager/image_manager.dart';

class FielManager {
  final FlameGame game;
  final ImageManager imageManager;
  int sizeLine;

  Function(bool check) hitTheTarget;

  double _time = 0;
  List<Fiel> _listFiel = [];
  late Random _random;
  int? _randomItem;

  late SpriteAnimation _activeAnimation;
  late SpriteAnimation _normalAnimation;
  late SpriteAnimation clickAnimation;

  FielManager(this.game, this.imageManager, this.hitTheTarget,
      {this.sizeLine = 3}) {
    _activeAnimation = SpriteAnimation.fromFrameData(
      imageManager.getItem('yellowField'),
      SpriteAnimationData.sequenced(
        textureSize: Vector2(250, 250),
        amount: 1,
        amountPerRow: 1,
        stepTime: 0.1,
      ),
    );

    _normalAnimation = SpriteAnimation.fromFrameData(
      imageManager.getItem('whiteField'),
      SpriteAnimationData.sequenced(
        textureSize: Vector2(250, 250),
        amount: 1,
        amountPerRow: 1,
        stepTime: 0.1,
      ),
    );
    clickAnimation = SpriteAnimation.fromFrameData(
      imageManager.getItem('boomAnimation'),
      SpriteAnimationData.sequenced(
        textureSize: Vector2(1000.0, 666),
        amount: 10,
        amountPerRow: 3,
        stepTime: 0.02,
        loop: false,
      ),
    );

    _random = Random();

    _restartArrays();
  }

  void update(double dt) {
    if (_time > 100) {
      _calcItem();
    }
    _time++;
  }

  _restartArrays() {
    double sizeX = game.size.x;
    double sizeY = game.size.y;

    double width = (sizeX * 0.8) / sizeLine;
    //double h = (sizeY * 0.3) / sizeLine;

    double dtX = (sizeX * 0.2) / (sizeLine + 1);
    //double dtY = (sizeY * 0.2) / (sizeLine+1);

    double startY = (sizeY * 0.5);

    for (int i = 0; i < sizeLine; i++) {
      for (int j = 0; j < sizeLine; j++) {
        Fiel fiel = Fiel(j + i * sizeLine, _onClickItem, _normalAnimation,
            clickAnimation, _activeAnimation)
          ..position =
              Vector2(dtX + (width + dtX) * j, startY + (width + dtX) * i)
          ..size = Vector2(width, width)
          ..anchor = Anchor.topLeft;
        _listFiel.add(fiel);
      }
    }
    _calcItem();
  }

  void resize(int size) {
    _randomItem = null;
    listFiel.clear();
    sizeLine = size;
    _restartArrays();
  }

  void _calcItem() {
    if (_randomItem != null) {
      _listFiel[_randomItem!].setActive(false);
    }
    _randomItem = _random.nextInt(_listFiel.length);

    _listFiel[_randomItem!].setActive(true);

    _time = 0;
  }

  List<Fiel> get listFiel => _listFiel;

  void _onClickItem(int index) {
    if (_randomItem == index) {
      print("Popal");
      _calcItem();
      hitTheTarget(true);
    } else {
      hitTheTarget(false);
    }
  }
}
