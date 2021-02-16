import 'dart:async';
import 'package:flappy_bird/barriers.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'bird.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;

  bool gameHasStarted = false;

  double barrierXone = 1;
  double barrierXtwo = 3.5;
  double barrierXthree = 6;
  double barrierXfour = 8.5;

  final GlobalKey birdkey = GlobalKey();
  Offset pos;

  void getPosition(key) {
    RenderBox birdBox = key.currentContext.findRenderObject();
    pos = birdBox.localToGlobal(Offset.zero);
    print(pos);
  }

  void jump() {
    setState(() {
      getPosition(birdkey);
      time = 0;
      initialHeight = birdYaxis;
      if (initialHeight > 1 || initialHeight < -1) {
        initState();
        setState(() {
          gameHasStarted = false;
        });
        birdYaxis = 0;
      }
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        if (barrierXone < -2) {
          barrierXone += 10.5;
        } else {
          barrierXone -= 0.1;
        }
        if (barrierXtwo < -2) {
          barrierXtwo += 10.5;
        } else {
          barrierXtwo -= 0.1;
        }
        if (barrierXthree < -2) {
          barrierXthree += 10.5;
        } else {
          barrierXthree -= 0.1;
        }
        if (barrierXfour < -2) {
          barrierXfour += 10.5;
        } else {
          barrierXfour -= 0.1;
        }
      });
      if (birdYaxis > 1 || birdYaxis < -1) {
        timer.cancel();
        birdYaxis = 0;
        barrierXone = 6;
        barrierXtwo = 6;
        barrierXthree = 6;
        barrierXfour = 6;
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(children: [
                AnimatedContainer(
                    key: birdkey,
                    alignment: Alignment(0, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: Container(child: Bird())),
                AnimatedContainer(
                  alignment: Alignment(barrierXone, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXone, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 300.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXtwo, -1.18),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 300.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXtwo, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXthree, -1.18),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXthree, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 250.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXfour, -1.18),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 250.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXfour, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                Container(
                  alignment: Alignment(0, -0.5),
                  child: Text(gameHasStarted ? ' ' : 'T A P    T O    P L A Y',
                      style: TextStyle(fontSize: 25, color: Colors.white70)),
                ),
              ]),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Score',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '0',
                          style: TextStyle(fontSize: 35),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Best Score',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '10',
                          style: TextStyle(fontSize: 35),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
