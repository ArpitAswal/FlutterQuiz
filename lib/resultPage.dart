import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class ScoreScreen extends StatefulWidget {

   const ScoreScreen( this.ans, {super.key});

  final List<dynamic> ans;

  @override
  State<ScoreScreen> createState() => _ScoreScreenState(ans);
}

class _ScoreScreenState extends State<ScoreScreen> {

  late ConfettiController _controller;
  int totalScore=0;
  late List<dynamic> answer;
  _ScoreScreenState(List<dynamic> ans){
    answer=ans;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateScore(answer);
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
      child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffe7bf74),
                      Color(0xfffcb69f),
                    ],
                    begin: FractionalOffset(1.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                  )),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(confettiController: _controller,
                          shouldLoop: true,
                          emissionFrequency: 0.05,
                          blastDirectionality: BlastDirectionality.explosive,
                          gravity: 0.1
                      ),
                    ),
                    const SizedBox(height: 300,),
                    Text("Hello ${MyHomePageState.name.text.toString()}",
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                          decoration: TextDecoration.none
                      ),
                      //textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5,), //Text
                    Text(
                      'Your Score is ' '$totalScore',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                          decoration: TextDecoration.none),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (totalScore == 9 ||
                        totalScore == 10) const Text(
                        '😇', style: TextStyle(fontSize: 40,decoration: TextDecoration.none)),
                    if (totalScore == 7 ||
                        totalScore == 8) const Text(
                        '😀', style: TextStyle(fontSize: 40,decoration: TextDecoration.none)),
                    if (totalScore >= 4 &&
                        totalScore <= 6) const Text(
                        '😔', style: TextStyle(fontSize: 40,decoration: TextDecoration.none)),
                    if (totalScore >= 0 &&
                        totalScore <= 3) const Text(
                        '😭', style: TextStyle(fontSize: 40,decoration: TextDecoration.none)),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          _controller.stop();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MyHomePage(
                                    title: '',
                                  )));
                        },
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white),
                          foregroundColor:
                          MaterialStateProperty.all(Colors.red.shade600),
                          shadowColor: MaterialStateProperty.all(
                              Colors.redAccent),
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
                   const SizedBox(height: 5,),
                    TextButton(
                        onPressed: () {
                          _controller.stop();
                          _pop();
                        },
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white),
                          foregroundColor:
                          MaterialStateProperty.all(Colors.red.shade600),
                          shadowColor: MaterialStateProperty.all(
                              Colors.red),
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
                          'Exit',
                        )),
                  ],),
              ),
            ),
          ]
      ),
    );
  }
  Future<bool> _pop() async{
    SystemNavigator.pop();
    return true;
  }

  void calculateScore(List<dynamic>ans) {
    for(int i=0;i<ans.length;i++){
      debugPrint("i=$i and ans[i]=${ans[i]}");
      if(ans[i]==true){
        totalScore++;
      }
    }
  }
}