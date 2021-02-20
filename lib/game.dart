import 'dart:async';
import 'package:flappy_bird/barriers.dart';

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

  double barrierXone = 4;
  double barrierXtwo = 6.5;
  double barrierXthree = 12;
  double barrierXfour = 14.5;

  final GlobalKey birdkey = GlobalKey();
  final GlobalKey onetkey = GlobalKey();
  final GlobalKey onebkey = GlobalKey();
  final GlobalKey twotkey = GlobalKey();
  final GlobalKey twobkey = GlobalKey();
  final GlobalKey threetkey = GlobalKey();
  final GlobalKey threebkey = GlobalKey();
  final GlobalKey fourtkey = GlobalKey();
  final GlobalKey fourbkey = GlobalKey();

  int score = 0;
  int bestScore = 10;

  Offset pos;

  String getPosition(key) {
    RenderBox birdBox = key.currentContext.findRenderObject();
    pos = birdBox.localToGlobal(Offset.zero);
    return (pos.toString());
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        if (barrierXone < -2) {
          barrierXone += 13.5;
        } else {
          barrierXone -= 0.1;
        }
        if (barrierXtwo < -2) {
          barrierXtwo += 13.5;
        } else {
          barrierXtwo -= 0.1;
        }
        if (barrierXthree < -2) {
          barrierXthree += 13.5;
        } else {
          barrierXthree -= 0.1;
        }
        if (barrierXfour < -2) {
          barrierXfour += 13.5;
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

  void jump() {
    String bird = getPosition(birdkey);
    String onet = getPosition(onetkey);
    String oneb = getPosition(onebkey);
    String twot = getPosition(twotkey);
    String twob = getPosition(twobkey);
    String threet = getPosition(threetkey);
    String threeb = getPosition(threebkey);
    String fourt = getPosition(fourtkey);
    String fourb = getPosition(fourbkey);
    var keys = [onet, oneb, twot, twob, threet, threeb, fourt, fourb];
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
      if (initialHeight > 1 || initialHeight < -1) {
        setState(() {
          gameHasStarted = false;
        });
        birdYaxis = 0;
      }
    });
  }

  void _showDialogue() {
    showDialog(context: context,
    builder: (BuildContext context)
    )
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
                  key: onetkey,
                  alignment: Alignment(barrierXone, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  key: onebkey,
                  alignment: Alignment(barrierXone, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 300.0,
                  ),
                ),
                AnimatedContainer(
                  key: twotkey,
                  alignment: Alignment(barrierXtwo, -1.18),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 300.0,
                  ),
                ),
                AnimatedContainer(
                  key: twobkey,
                  alignment: Alignment(barrierXtwo, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  key: threetkey,
                  alignment: Alignment(barrierXthree, -1.18),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  key: threebkey,
                  alignment: Alignment(barrierXthree, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 250.0,
                  ),
                ),
                AnimatedContainer(
                  key: fourtkey,
                  alignment: Alignment(barrierXfour, -1.18),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 250.0,
                  ),
                ),
                AnimatedContainer(
                  key: fourbkey,
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
                // decoration: ,
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
                          '$score',
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
                          '$bestScore',
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
