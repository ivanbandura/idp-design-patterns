import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'cube_enemy.dart';

class UiScreen extends StatefulWidget {
  const UiScreen({Key? key}) : super(key: key);

  @override
  State<UiScreen> createState() => _UiScreenState();
}

num map(num value,
        [num iStart = 0, num iEnd = pi * 2, num oStart = 0, num oEnd = 1.0]) =>
    ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;

class _UiScreenState extends State<UiScreen> {
  final List<Widget> _list = <Widget>[];
  final double _size = 140.0;
  double _x = pi * 0.25, _y = pi * 0.25;
  Timer? _timer;

  int get size => _list.length;
  CubeEnemy cubeEnemy = CubeEnemy();
  StreamController streamController = StreamController();
  late StreamSubscription streamSubscription;

  String data = '';

  @override
  void initState() {
    streamSubscription = streamController.stream.listen((event) {
      print('event $event');
      data = event;
    });

    List<int> inter = [3, 5, 5, 5, 3, 6, 78, 6, 67, 5, 6, 5, 2];

    List<int> changed = [];
    Map<int, int> countMap = {};

    inter.forEach((element) {
      countMap[element] = (countMap[element] ?? 0) + 1;
    });
    inter.removeWhere((element) => countMap[element]! > 1);
    print('countMap $countMap');
    print('countMap $inter');

    Map<int, int> occur = {};
    for (int i in inter) {
      occur[i] = occur.containsKey(i) ? occur[i]! + 1 : 1;
    }
    print('occur $occur');

    inter.removeWhere((element) => occur[element]! > 1);

    print('inter $inter');

    Map<int, int> occurrences = {};
    for (int value in inter) {
      occurrences[value] =
          occurrences.containsKey(value) ? occurrences[value]! + 1 : 1;
    }
    inter.removeWhere((value) => occurrences[value]! > 1);
    print(occurrences);

    print(inter);
  }

  @override
  void didChangeDependencies() {
    List<int> inter = [2, 5, 5, 5, 3, 6, 78, 3, 67, 5, 6, 5, 1];

    Map<int, int> map = {};

    List<int> uniqueInts = [];
    inter.forEach((element) {
      print('inter.indexOf(element) ${inter.indexOf(element)}');

      if (inter.indexOf(element) == inter.lastIndexOf(element)) {
        uniqueInts.add(element);
      }
    });

    List<int> list = List.generate(10, (index) => 21);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            body: Row(
      children: [
        Column(
          children: [
            const Text('Hit the enemy by double tap'),
            Center(
              child: Container(
                width: 305, // Set the width explicitly
                height: 400,
                child: Stack(children: <Widget>[
                  // Rainbow
                  LayoutBuilder(
                      builder: (_, BoxConstraints c) => Stack(
                              children: _list.map((Widget w) {
                            final num i = map(size - _list.indexOf(w), 0, 150);
                            return Positioned(
                                top: (c.maxHeight / 2 - _size / 2) +
                                    i * c.maxHeight * 0.9,
                                left: (c.maxWidth / 2 - _size / 2) -
                                    i * c.maxWidth * 0.9,
                                child: Transform.scale(
                                    scale: i * 1.5 + 1.0, child: w));
                          }).toList())),

                  // Cube
                  GestureDetector(
                      onDoubleTap: _start,
                      onPanUpdate: (DragUpdateDetails u) => setState(() {
                            _x = (_x + -u.delta.dy / 150) % (pi * 2);
                            _y = (_y + -u.delta.dx / 150) % (pi * 2);
                          }),
                      child: Container(
                          color: Colors.transparent,
                          child: Cube(
                              color: Colors.grey.shade200,
                              x: _x,
                              y: _y,
                              size: _size))),
                ]),
              ),
            )
          ],
        ),
        Column(children: [
          Text('health: ${cubeEnemy.health.toString()}'),
          Text(
            data,
            style: TextStyle(
                color: data == '' ? Colors.black : Colors.red, fontSize: 20),
          )
        ])
      ],
    )));
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void _start() {
    int rnd = Random().nextInt(100);
    streamController.sink.add(cubeEnemy.receiveDamage(Random().nextInt(100)));
    _timer = Timer(const Duration(milliseconds: 48), () {
      _add();
    });
    // _timer = Timer.periodic(const Duration(milliseconds: 400), (_) => _add());
    if (_timer!.isActive) {
      return;
    }
  }

  void _add() {
    if (size > 150) {
      _list.removeRange(0, Colors.accents.length * 4);
    } // Expensive, remove more at once

    setState(() => _list.add(Cube(
        x: _x,
        y: _y,
        color: Colors.accents[_timer!.tick % Colors.accents.length]
            .withOpacity(0.2),
        rainbow: true,
        size: _size)));
  }
}

class Cube extends StatelessWidget {
  const Cube(
      {super.key,
      required this.x,
      required this.y,
      required this.color,
      required this.size,
      this.rainbow = false});

  static const double _shadow = 0.2, _halfPi = pi / 2, _oneHalfPi = pi + pi / 2;

  final double x, y, size;
  final Color color;
  final bool rainbow;

  double get _sum => (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);

  @override
  Widget build(BuildContext context) {
    final bool topBottom = x < _halfPi || x > _oneHalfPi;
    final bool northSouth = _sum < _halfPi || _sum > _oneHalfPi;
    final bool eastWest = _sum < pi;

    return Stack(children: <Widget>[
      _side(
          zRot: y,
          xRot: -x,
          shadow: _getShadow(x).toDouble(),
          moveZ: topBottom),
      _side(
          yRot: y,
          xRot: _halfPi - x,
          shadow: _getShadow(_sum).toDouble(),
          moveZ: northSouth),
      _side(
          yRot: -_halfPi + y,
          xRot: _halfPi - x,
          shadow: _shadow - _getShadow(_sum),
          moveZ: eastWest)
    ]);
  }

  num _getShadow(double r) {
    if (r < _halfPi) {
      return map(r, 0, _halfPi, 0, _shadow);
    } else if (r > _oneHalfPi) {
      return _shadow - map(r, _oneHalfPi, pi * 2, 0, _shadow);
    } else if (r < pi) {
      return _shadow - map(r, _halfPi, pi, 0, _shadow);
    }

    return map(r, pi, _oneHalfPi, 0, _shadow);
  }

  Widget _side(
      {bool moveZ = true,
      double xRot = 0.0,
      double yRot = 0.0,
      double zRot = 0.0,
      double shadow = 0.0}) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateX(xRot)
        ..rotateY(yRot)
        ..rotateZ(zRot)
        ..translate(0.0, 0.0, moveZ ? -size / 2 : size / 2),
      child: Container(
        alignment: Alignment.center,
        child: Container(
            constraints: BoxConstraints.expand(width: size, height: size),
            color: color,
            foregroundDecoration: BoxDecoration(
              color: Colors.black.withOpacity(rainbow ? 0.0 : shadow),
              border: Border.all(
                width: 0.8,
                color: rainbow ? color.withOpacity(0.3) : Colors.black26,
              ),
            ),
            child: Image.asset("assets/images/enemy_logo.png")),
      ),
    );
  }
}

/*
class InfiniteScrollController implements ChangeNotifier {
  List<Widget> items = [];

  void clearItems() {
    items.clear();
    notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }
}
*/

/*
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class UiScreen extends StatefulWidget {
  const UiScreen({Key? key}) : super(key: key);

  @override
  State<UiScreen> createState() => _UiScreenState();
}

num map(num value,
    [num iStart = 0, num iEnd = pi * 2, num oStart = 0, num oEnd = 1.0]) =>
    ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;

class _UiScreenState extends State<UiScreen> {
  final List<Widget> _list = <Widget>[];
  final double _size = 140.0;

  double _x = pi * 0.25, _y = pi * 0.25;
  late Timer _timer;

  int get size => _list.length;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            body: Column(
              children: [
                Text(' Hit the enemy'),
                SizedBox(height: 200,),
                Stack(children: <Widget>[
                  // Rainbow
                  LayoutBuilder(
                      builder: (_, BoxConstraints c) => Stack(
                          children: _list.map((Widget w) {
                            final num i = map(size - _list.indexOf(w), 0, 150);

                            return Positioned(
                                top: (c.maxHeight / 2 - _size / 2) +
                                    i * c.maxHeight * 0.9,
                                left:
                                (c.maxWidth / 2 - _size / 2) - i * c.maxWidth * 0.9,
                                child: Transform.scale(scale: i * 1.5 + 1.0, child: w));
                          }).toList())),

                  // Cube
                  GestureDetector(
                      onDoubleTap: _start,
                      onPanUpdate: (DragUpdateDetails u) => setState(() {
                        _x = (_x + -u.delta.dy / 150) % (pi * 2);
                        _y = (_y + -u.delta.dx / 150) % (pi * 2);
                      }),
                      child: Container(
                          color: Colors.transparent,
                          child: Cube(
                              color: Colors.grey.shade200, x: _x, y: _y, size: _size))),
                ])
              ],
            )));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _start() {
    if (_timer.isActive) {
      return;
    }

    _timer = Timer.periodic(const Duration(milliseconds: 48), (_) => _add());
  }

  void _add() {
    if (size > 150) {
      _list.removeRange(0, Colors.accents.length * 4);
    } // Expensive, remove more at once

    setState(() => _list.add(Cube(
        x: _x,
        y: _y,
        color: Colors.accents[_timer.tick % Colors.accents.length]
            .withOpacity(0.2),
        rainbow: true,
        size: _size)));
  }
}

class Cube extends StatelessWidget {
  const Cube(
      {super.key,
        required this.x,
        required this.y,
        required this.color,
        required this.size,
        this.rainbow = false});

  static const double _shadow = 0.2, _halfPi = pi / 2, _oneHalfPi = pi + pi / 2;

  final double x, y, size;
  final Color color;
  final bool rainbow;

  double get _sum => (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);

  @override
  Widget build(BuildContext context) {
    final bool topBottom = x < _halfPi || x > _oneHalfPi;
    final bool northSouth = _sum < _halfPi || _sum > _oneHalfPi;
    final bool eastWest = _sum < pi;

    return Stack(children: <Widget>[
      _side(
          zRot: y,
          xRot: -x,
          shadow: _getShadow(x).toDouble(),
          moveZ: topBottom),
      _side(
          yRot: y,
          xRot: _halfPi - x,
          shadow: _getShadow(_sum).toDouble(),
          moveZ: northSouth),
      _side(
          yRot: -_halfPi + y,
          xRot: _halfPi - x,
          shadow: _shadow - _getShadow(_sum),
          moveZ: eastWest)
    ]);
  }

  num _getShadow(double r) {
    if (r < _halfPi) {
      return map(r, 0, _halfPi, 0, _shadow);
    } else if (r > _oneHalfPi) {
      return _shadow - map(r, _oneHalfPi, pi * 2, 0, _shadow);
    } else if (r < pi) {
      return _shadow - map(r, _halfPi, pi, 0, _shadow);
    }

    return map(r, pi, _oneHalfPi, 0, _shadow);
  }

  Widget _side(
      {bool moveZ = true,
        double xRot = 0.0,
        double yRot = 0.0,
        double zRot = 0.0,
        double shadow = 0.0}) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateX(xRot)
        ..rotateY(yRot)
        ..rotateZ(zRot)
        ..translate(0.0, 0.0, moveZ ? -size / 2 : size / 2),
      child: Container(
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints.expand(width: size, height: size),
          color: color,
          foregroundDecoration: BoxDecoration(
            color: Colors.black.withOpacity(rainbow ? 0.0 : shadow),
            border: Border.all(
              width: 0.8,
              color: rainbow ? color.withOpacity(0.3) : Colors.black26,
            ),
          ),
          child: const FlutterLogo(
            size: 200,
          ),
        ),
      ),
    );
  }
}
*/
