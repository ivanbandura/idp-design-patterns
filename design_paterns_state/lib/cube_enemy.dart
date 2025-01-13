import 'dart:math';

import 'package:design_paterns_state/enemy.dart';

import 'cube_enemy_state.dart';

class CubeEnemy implements Enemy {
  int _health = 1000;
  late CubeEnemyState _cubeEnemyState = CubeEnemyNormalState(this);

  int get health => _health;

  set health(int damage) {
    print('damage $damage');
    _health = _health - damage;
  }

  void setEnemyState() {
    final Random random = Random();
    int randomNumber =
    random.nextInt(100); // Generates a random number between 0 and 99

    if (randomNumber < 10) {
      _cubeEnemyState = CubeEnemyBleedingState(this);
    } else {
      randomNumber =
          random.nextInt(2); // Generates a random number between 0 and 1
      switch (randomNumber) {
        case 0:
          _cubeEnemyState = CubeEnemyDeadState(this);
          break;
        case 1:
          _cubeEnemyState = CubeEnemyNormalState(this);
          break;
        default:
          throw Exception("Invalid random number generated");
      }
    }
    }



  void getRandomState() {
    final Random random = Random();
    int randomNumber =
    random.nextInt(100); // Generates a random number between 0 and 99

    if (randomNumber < 10) {
      _cubeEnemyState = CubeEnemyBleedingState(this);
    } else {
      randomNumber =
          random.nextInt(2); // Generates a random number between 0 and 1
      switch (randomNumber) {
        case 0:
          _cubeEnemyState = CubeEnemyDeadState(this);
          break;
        case 1:
          _cubeEnemyState = CubeEnemyNormalState(this);
          break;
        default:
          throw Exception("Invalid random number generated");
      }
    }
  }

  @override
  String receiveDamage(int damage) {
    return _cubeEnemyState.receiveDamage(damage);
  }

// void changeState(CubeEnemyState state) {
//   final Random random = Random();
//   int randomNumber =
//       random.nextInt(100); // Generates a random number between 0 and 99
//
// }
}
