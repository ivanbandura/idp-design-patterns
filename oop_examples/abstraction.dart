abstract class Robot {
  void performAction();
}

class DancingRobot extends Robot {
  @override
  void performAction() {
    print('Dancing Robot: Performing a dance!');
  }
}

void main() {
  Robot myRobot = DancingRobot();

  myRobot.performAction();
}
