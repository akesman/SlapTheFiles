import 'package:flame/game.dart';

class ImageManager {
  late Map<String, dynamic> dataImages;
  final FlameGame game;

  ImageManager(this.game) {
    dataImages = {};
  }

  init() async {
    dataImages['boomAnimation'] = await game.images.load("boomAnimation.png");
    dataImages['spriteField'] = await game.images.load("spriteField.png");
    dataImages['spriteFieldActive'] = await game.images.load("spriteFieldActive.png");
    dataImages['background'] = await game.images.load("background.jpg");

    dataImages['whiteField'] = await game.images.load("whiteField.png");
    dataImages['yellowField'] = await game.images.load("yellowField.png");
  }

  dynamic getItem(String nameItem) {
    if (dataImages.containsKey(nameItem)) {
      return dataImages[nameItem];
    }
    return null;
  }
}
