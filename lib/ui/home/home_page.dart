import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bird_tap_app/ui/global_widgets/bird.dart';
import 'package:bird_tap_app/ui/global_widgets/barriel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static bool gameStarted = false;
  static double birdAxisY = 0;
  double initH = birdAxisY;
  double barrYBottom = 1.2;
  double barrYTop = -1.2;
  double finalScore = 0;
  double barrsX1 = 1;
  double barrsX2 = 3;
  double height = 0;
  double score = 0;
  double time = 0;

  //? TAP JUMP
  jump() {
    setState(() {
      time = 0;
      initH = birdAxisY - 0.4;
    });
  }

  //? LONG TAP JUMP
  jumpLarge() {
    setState(() {
      time = 0;
      initH -= birdAxisY;
    });
  }

  //? START JUMPING
  startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      time += 0.04;
      height = -4.8 * time + 3 * time;

      setState(() {
        birdAxisY = initH - height;
        score += 0.15;

        print(
          'time: $time'
          '\ninitH = $initH'
          '\nscore = $score'
          '\nheight: $height'
          '\nbarrX1: $barrsX1'
          '\nbarrX2: $barrsX2'
          '\nbirdAxisY: $birdAxisY',
        );
      });

      //? BARRIELS 1
      setState(() {
        if (barrsX1 < -2) {
          barrsX1 += 4;
        } else {
          barrsX1 -= 0.05;
        }
      });

      //? BARRIELS 2
      setState(() {
        if (barrsX2 < -2) {
          barrsX2 += 4;
        } else {
          barrsX2 -= 0.05;
        }
      });

      if (barrYTop > coordinates(birdAxisY) &&
          (barrYTop - barrYTop).abs() < 0.03) {
        timer.cancel();
        if (score > finalScore) {
          finalScore = score;
        }
        time = 0;
        score = 0;
        height = 0;
        barrsX1 = 1;
        barrsX2 = 2;
        birdAxisY = 0;
        initH = birdAxisY;
        gameStarted = false;
      }

      if (birdAxisY > 1.1) {
        timer.cancel();
        if (score > finalScore) {
          finalScore = score;
        }
        time = 0;
        score = 0;
        height = 0;
        barrsX1 = 0.5;
        barrsX2 = 2;
        birdAxisY = 0;
        initH = birdAxisY;
        gameStarted = false;
      }
    });
  }

  //? HEIGHT COORDINATE
  double coordinates(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double birdAxisY = 1 - 2 * height / totalHeight;
    return birdAxisY;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //? LONG TAPS ACTIONS
      onLongPress: () {
        jumpLarge();
      },
      //? TAPS ACTIONS
      onTap: () {
        if (gameStarted) {
          jump();
        } else {
          startGame();
          // showDialog(
          //   context: context,
          //   builder: (_) => WillPopScope(
          //     onWillPop: () async => true,
          //     child: CupertinoAlertDialog(
          //       title: Text('Game Over'),
          //       content: Text('Do You wanna play again?'),
          //       actions: [
          //         CupertinoDialogAction(
          //           child: Text('OK'),
          //           onPressed: () {},
          //         ),
          //       ],
          //     ),
          //   ),
          // );
        }
      },
      child: Scaffold(
        // appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Column(
                    children: [
                      //? SKY / BIRD / CESPED BORDER
                      Expanded(
                        child: AnimatedContainer(
                          color: Colors.blue.shade300,
                          alignment: Alignment(0, birdAxisY),
                          duration: const Duration(milliseconds: 0),
                          child: const SizedBox(
                            width: 75,
                            height: 75,
                            child: Bird(),
                          ),
                        ),
                      ),
                      //? CESPED BORDER
                      Container(
                        height: 10,
                        width: double.infinity,
                        color: Colors.green.shade900,
                      ),
                    ],
                  ),
                  //? BARRIELS
                  MyAnimate(barrX: barrsX1, size: 240, barrY: 1.2),
                  MyAnimate(barrX: barrsX1, size: 260, barrY: -1.05),
                  MyAnimate(barrX: barrsX2, size: 200, barrY: 1.2),
                  MyAnimate(barrX: barrsX2, size: 300, barrY: -1.05),
                  //? TAP START TEXT
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameStarted
                        ? const Text('')
                        : const Text(
                            'Tap To Play',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            //? CESPED
            Container(
              height: 20,
              color: Colors.green,
            ),
            //? SCORE TEXTS / TIERRA
            Expanded(
              child: Container(
                color: Colors.brown.shade400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //? SCORE
                    Text(
                      'Score:\n\n${score.toInt()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    //? BEST
                    Text(
                      'Best:\n\n${finalScore.toInt()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
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

class MyAnimate extends StatelessWidget {
  const MyAnimate({
    Key? key,
    required this.size,
    required this.barrX,
    required this.barrY,
  }) : super(key: key);

  final double barrX, size, barrY;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      child: Barriel(size: size),
      alignment: Alignment(barrX, barrY),
      duration: Duration(milliseconds: 0),
    );
  }
}
