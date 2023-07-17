import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class resultPage extends StatefulWidget {
  int totalscore = 0;

  resultPage( int score) {
    totalscore = score;
  }

  @override
  State<resultPage> createState() => _resultPageState();
}

class _resultPageState extends State<resultPage> {

  late ConfettiController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = ConfettiController(duration: const Duration(seconds: 10));
    _controller.play();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    SizedBox(height: 300,),
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
                      'Your Score is ' '${widget.totalscore}',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                          decoration: TextDecoration.none),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.totalscore == 9 ||
                        widget.totalscore == 10) const Text(
                        '😇', style: TextStyle(fontSize: 40,decoration: TextDecoration.none)),
                    if (widget.totalscore == 7 ||
                        widget.totalscore == 8) const Text(
                        '😀', style: TextStyle(fontSize: 40,decoration: TextDecoration.none)),
                    if (widget.totalscore >= 4 &&
                        widget.totalscore <= 6) const Text(
                        '😔', style: TextStyle(fontSize: 40,decoration: TextDecoration.none)),
                    if (widget.totalscore >= 0 &&
                        widget.totalscore <= 3) const Text(
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
                        child: Text(
                          'Restart',
                        ),
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
                        )),
                   SizedBox(height: 5,),
                    TextButton(
                        onPressed: () {
                          _controller.stop();
                          _pop();
                        },
                        child: Text(
                          'Exit',
                        ),
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
}