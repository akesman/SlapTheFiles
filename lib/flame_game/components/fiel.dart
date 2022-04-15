import 'package:flame/components.dart';
import 'package:flame/input.dart';

class Fiel extends SpriteAnimationComponent with Tappable {
  final int index;
  Function(int index) onClick;
  final SpriteAnimation normalAnimation;
  final SpriteAnimation clickAnimation;
  final SpriteAnimation activeAnimation;

  Fiel(this.index, this.onClick, this.normalAnimation, this.clickAnimation,
      this.activeAnimation) {
    animation = normalAnimation.clone();
  }

  double _animationDuration = double.minPositive;
  bool _activeItem = false;

  @override
  Future<void>? onLoad() {
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_animationDuration == double.minPositive) return;

    if (_animationDuration <= 0) {
      if (_activeItem) {
        animation = activeAnimation.clone();
      } else {
        animation = normalAnimation.clone();
      }
      _animationDuration = double.minPositive;
    } else {
      _animationDuration -= dt;
    }
  }

  setActive(bool active) {
    _activeItem = active;
    if (active) {
      animation = activeAnimation.clone();
    } else {
      animation = normalAnimation.clone();
    }
  }

  @override
  bool onTapDown(TapDownInfo info) {
    onClick(index);
    _animationDuration = 0.2;
    animation = clickAnimation.clone();
    return super.onTapDown(info);
  }
}
