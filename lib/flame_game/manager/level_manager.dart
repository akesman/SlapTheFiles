import 'package:kick/flame_game/components/level_panel.dart';
import 'package:kick/flame_game/components/score_panel.dart';

class LevelManager {
  final ScorePanel scorePanel;
  final LevelPanel levelPanel;
  final Function(int level) changeLvl;

  LevelManager(this.scorePanel, this.levelPanel, this.changeLvl);

  int _addingPoints = 1;
  double _timeReduction = 0.002;
  double _addingTime = 0.08;

  update() {
    int level = levelPanel.level;
    int point = scorePanel.points;

    if (level == 1 && point > 20) {
      _levelChange(2);
    } else if (level == 2 && point > 80) {
      _levelChange(3);
    } else if (level == 3 && point > 160) {
      _levelChange(4);
    } else if (level == 4 && point > 320) {
      _levelChange(5);
    }
  }

  _levelChange(int level) {
    levelPanel.setLevel(level);
    _addingPoints = 2 * level;
    _timeReduction = 0.0007 * level;
    _addingTime = 0.08 - (0.01 * level);

    changeLvl(level);
  }

  double get timeReduction => _timeReduction;

  double get addingTime => _addingTime;

  int get addingPoints => _addingPoints;
}
