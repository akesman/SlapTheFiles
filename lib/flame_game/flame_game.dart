import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick/cubit/game_cubit/game_cubit.dart';
import 'package:kick/cubit/user_cubit/user_cubit.dart';
import 'package:kick/data/models/user.dart';
import 'package:kick/flame_game/components/fiel_manager.dart';
import 'package:kick/flame_game/components/image_manager.dart';
import 'package:kick/flame_game/components/progress_bar.dart';
import 'package:kick/flame_game/components/score_panel.dart';
import 'package:kick/flame_game/overlays/game_over_menu.dart';
import 'package:kick/flame_game/overlays/pause_button.dart';
import 'package:kick/flame_game/overlays/pause_menu.dart';

class SFgame extends FlameGame with HasTappables {
  final BuildContext context;
  FielManager? fielManager;
  late ProgressBarIndicator progressBarIndicator;
  late ScorePanel scorePanel;
  late ImageManager imageManager;
  bool isRunning = true;

  SFgame(this.context);

  @override
  Future<void>? onLoad() async {
    Flame.device.fullScreen();

    imageManager = ImageManager(this);
    await imageManager.init();

    fielManager = FielManager(this, imageManager, hitTheTarget);

    progressBarIndicator = ProgressBarIndicator(timeOver, size);
    scorePanel = ScorePanel(size);

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
    add(progressBarIndicator);

    return super.onLoad();
  }

  void timeOver() {
    isRunning = false;
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
    isRunning = true;
    scorePanel.reset();
    progressBarIndicator.value = 1;
  }

  void hitTheTarget(bool check) {
    if (!isRunning) return;

    if (check) {
      scorePanel.setPoint(1);
      progressBarIndicator.addTime();
    } else {
      scorePanel.setPoint(-1);
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

  @override
  void update(double dt) {
    super.update(dt);
    if (!isRunning) return;
    fielManager!.update(dt);
  }
}
