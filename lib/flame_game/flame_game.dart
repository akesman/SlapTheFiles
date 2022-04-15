import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick/cubit/user_cubit/user_cubit.dart';
import 'package:kick/data/models/user.dart';
import 'package:kick/flame_game/components/level_panel.dart';
import 'package:kick/flame_game/components/progress_bar.dart';
import 'package:kick/flame_game/components/score_panel.dart';
import 'package:kick/flame_game/manager/fiel_manager.dart';
import 'package:kick/flame_game/manager/image_manager.dart';
import 'package:kick/flame_game/manager/level_manager.dart';
import 'package:kick/flame_game/overlays/game_over_menu.dart';
import 'package:kick/flame_game/overlays/pause_button.dart';
import 'package:kick/flame_game/overlays/pause_menu.dart';

class SFgame extends FlameGame with HasTappables {
  final BuildContext context;
  FielManager? fielManager;
  late ProgressBarIndicator progressBarIndicator;
  late ScorePanel scorePanel;
  late LevelPanel levelPanel;
  late ImageManager imageManager;
  late LevelManager levelManager;

  SFgame(this.context);

  @override
  Future<void>? onLoad() async {
    imageManager = ImageManager(this);
    await imageManager.init();

    fielManager = FielManager(this, imageManager, hitTheTarget);

    scorePanel = ScorePanel(size);
    levelPanel = LevelPanel(size);
    levelManager = LevelManager(scorePanel, levelPanel, changeLevel);

    progressBarIndicator = ProgressBarIndicator(timeOver, size, levelManager);

    ParallaxImage(imageManager.getItem("background"));

    ParallaxComponent _back = await ParallaxComponent.load(
      [ParallaxImageData("background.jpg")],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(2, 0),
    );

    add(_back);
    addAll(fielManager!.listFiel);
    add(scorePanel);
    add(levelPanel);
    add(progressBarIndicator);

    return super.onLoad();
  }

  void timeOver() {
    saveData();

    this.pauseEngine();
    this.overlays.remove(PauseButton.ID);
    this.overlays.add(GameOverMenu.ID);
  }

  saveData() {
    User currUser = BlocProvider.of<UserCubit>(context).currentUser!;
    if (currUser.point! < scorePanel.points) {
      User saveUser = BlocProvider.of<UserCubit>(context)
          .currentUser!
          .merge(User(point: scorePanel.points));
      BlocProvider.of<UserCubit>(context).addUser(saveUser);
    }
  }

  void restart() {
    scorePanel.reset();
    levelPanel.reset();
    progressBarIndicator.value = 1;
    changeLevel(1);
  }

  void hitTheTarget(bool check) {
    if (check) {
      scorePanel.addPoint(levelManager.addingPoints);
      progressBarIndicator.addTime();
    } else {
      scorePanel.addPoint(-levelManager.addingPoints);
      progressBarIndicator.loseTime();
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        // if (this._player.health > 0) {
        this.pauseEngine();
        this.overlays.remove(PauseButton.ID);
        this.overlays.add(PauseMenu.ID);
        //  }
        break;
    }

    super.lifecycleStateChange(state);
  }

  void changeLevel(int level) {
    removeAll(fielManager!.listFiel);
    fielManager!.resize(level + 2);
    addAll(fielManager!.listFiel);
  }

  @override
  void update(double dt) {
    super.update(dt);
    fielManager!.update(dt);
    levelManager.update();
  }
}
