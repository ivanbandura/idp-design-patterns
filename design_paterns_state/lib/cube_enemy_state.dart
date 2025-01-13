import 'dart:math';

import 'cube_enemy.dart';

abstract class CubeEnemyState {
  final CubeEnemy enemy;
  CubeEnemyState(this.enemy);

  String receiveDamage(int damage);
}

class CubeEnemyDeadState extends CubeEnemyState {
  CubeEnemyDeadState(super.enemy);

  @override
  String receiveDamage(int damage) {
    enemy.setEnemyState();

    print('dead - nothing to do');
    return 'dead - nothing to do';
  }
}

class CubeEnemyBleedingState extends CubeEnemyState {
  CubeEnemyBleedingState(super.enemy);

  @override
  String receiveDamage(int damage) {
    print('rand NO');
    enemy.setEnemyState();
    enemy.health = enemy.health - damage *2;
    print('CubeEnemyBleedingState - damage * 2 $damage');
    return 'CubeEnemyBleedingState - damage * 2 $damage';
  }
}

class CubeEnemyNormalState extends CubeEnemyState {
  CubeEnemyNormalState(super.enemy);

  @override
  String receiveDamage(int damage) {
    enemy.health = enemy.health - damage;
    int rand = Random().nextInt(10);
    print('rand $rand');
    if (rand == 1) {
      enemy.setEnemyState();
      enemy.health = enemy.health - damage *2;
      print('CubeEnemyBleedingState - damage * 2 $damage ${damage*2}');
      return 'CubeEnemyBleedingState - damage * 2 $damage';
    } else {
      print('CubeEnemyNormalState - damage  $damage');
      return 'CubeEnemyNormalState - damage  $damage';

    }
  }
}
