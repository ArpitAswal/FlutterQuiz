import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen(this.ans, this.timeTaken, {super.key});

  final List<dynamic> ans;
  final int timeTaken;

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late ConfettiController _controller;
  int totalScore = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateScore(widget.ans);
    _controller = ConfettiController(duration: const Duration(seconds: 10));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _pop(),
      child: Stack(alignment: Alignment.topCenter, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xffe7bf74),
              Color(0xfffcb69f),
            ],
            begin: FractionalOffset(1.0, 0.0),
            end: FractionalOffset(0.0, 1.0),
          )),
        ),
        const SizedBox(
          height: 60,
        ),
        ConfettiWidget(
            confettiController: _controller,
            shouldLoop: true,
            emissionFrequency: 0.05,
            blastDirectionality: BlastDirectionality.explosive,
            gravity: 0.1),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Score: $totalScore",
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent,
                  decoration: TextDecoration.none,),
                //textAlign: TextAlign.center,
              ),
              const SizedBox(height:6.0),
              Text(
                "Total Time: ${widget.timeTaken}sec",
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent,
                  decoration: TextDecoration.none,),
                //textAlign: TextAlign.center,
              ),
              const SizedBox(height:12.0),
              Text( totalScore >= 9 ? '😇' : totalScore >= 7 ? '😀' : totalScore >= 4 ? '😔' : '😭',
                  style: const TextStyle(
                      fontSize: 40, decoration: TextDecoration.none)),
            ],
          ),
        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22.0),
            child: TextButton(
                onPressed: () {
                  _controller.stop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                          )));
                },
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.w500)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor:
                  MaterialStateProperty.all(Colors.red.shade600),
                  shadowColor: MaterialStateProperty.all(Colors.redAccent),
                  minimumSize: MaterialStateProperty.all(const Size(150, 30)),
                  elevation: MaterialStateProperty.all(15),
                  side: MaterialStateProperty.all(const BorderSide(
                    width: 2,
                    color: Colors.deepOrangeAccent,
                  )),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                child: const Text(
                  'Restart',
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22.0),
            child: TextButton(
                onPressed: () {
                  _controller.stop();
                  _pop();
                },
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.w500)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor:
                  MaterialStateProperty.all(Colors.red.shade600),
                  shadowColor: MaterialStateProperty.all(Colors.red),
                  minimumSize: MaterialStateProperty.all(const Size(120, 30)),
                  elevation: MaterialStateProperty.all(10),
                  side: MaterialStateProperty.all(const BorderSide(
                    width: 2,
                    color: Colors.deepOrangeAccent,
                  )),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                child: const Text(
                  'Exit',
                )),
          ),
        ),
      ]),
    );
  }

  Future<bool> _pop() async {
    SystemNavigator.pop();
    return true;
  }

  void calculateScore(List<dynamic> ans) {
    for (int i = 0; i < ans.length; i++) {
      if (ans[i] == true) {
        totalScore++;
      }
    }
  }
}
