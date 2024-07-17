
import 'package:FlutterQuiz/questions.dart';
import 'package:FlutterQuiz/resultPage.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class PlayQuiz extends StatefulWidget {
  const PlayQuiz({super.key});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  PageController? _controller;
  late List<String> selectedAnswers;
  List correctAnswers = List.filled(questions.length, false, growable: false);
  static int questionIndex = 0;
  late final int duration;
  DateTime? startTime;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    startTimer();
    duration = 90;
    selectedAnswers = List.filled(questions.length, '', growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff2a4bce),
        body: Stack(alignment: Alignment.topCenter,
            children:[
            PageView.builder(
              controller: _controller,
              onPageChanged: (page) {
                setState(() {
                  questionIndex = page;
                });
              },
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.6), // Shadow color with opacity
                                blurRadius: 10.0, // Blur radius of the shadow
                                spreadRadius:
                                    2.0, // Spread radius of the shadow (optional)
                                offset: const Offset(
                                    5.0, 5.0), // Offset of the shadow (x, y)
                              ),
                            ],
                            border: Border.all(color: Colors.white, width: 1.5),
                            image: const DecorationImage(
                                image: AssetImage(
                                  'assets/studydesk.png',
                                ),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 50.0),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Question ${index + 1}/10",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        indent: 10.0,
                        endIndent: 10.0,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "${questions[index].question}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21.0,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      for (int i = 0; i < questions[index].answers.length; i++)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                                fillColor:
                                    const MaterialStatePropertyAll<Color>(
                                        Colors.amber),
                                value:
                                    questions[index].answers.keys.toList()[i],
                                groupValue: selectedAnswers[index],
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedAnswers[index] = value!;
                                    if (value ==
                                            questions[index]
                                                .answers
                                                .keys
                                                .toList()[i] &&
                                        questions[index]
                                                .answers
                                                .values
                                                .toList()[i] ==
                                            true) {
                                      correctAnswers[questionIndex] = true;
                                    } else {
                                      correctAnswers[questionIndex] = false;
                                    }
                                  });
                                }),
                            Expanded(
                              child: Text(
                                  questions[index].answers.keys.toList()[i],
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  textDirection: TextDirection.ltr,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                    ]);
              }),
              (questionIndex+1 == questions.length)
                  ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 14),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        int timeTaken = getTime();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ScoreScreen(correctAnswers,timeTaken)));
                      },
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.red),
                        shadowColor:
                        MaterialStateProperty.all(Colors.black54),
                        elevation: MaterialStateProperty.all(10),
                        side: MaterialStateProperty.all(const BorderSide(
                          width: 1.5,
                          color: Colors.redAccent,
                        )),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                      child: const Text('Submit'),
                    ),
                  ))
                  : const SizedBox(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0, bottom: 12.0),
                child: CircularCountDownTimer(
                  duration: duration,
                  initialDuration: 0,
                  isReverse: true,
                  controller: CountDownController(),
                  width: 120,
                  height: 120,
                  ringColor: Colors.green[300]!,
                  fillColor: Colors.red[400]!,
                  backgroundColor: const Color(0xff2a4bce),
                  strokeWidth: 10.0,
                  strokeCap: StrokeCap.round,
                  textStyle: const TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  onComplete: timeFinished,
                ),
              ),
            ),
        ]));
  }

  void timeFinished() {
    int remainingTime = getTime();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ScoreScreen(correctAnswers, remainingTime)));
  }

  void startTimer() {
    startTime = DateTime.now();
  }

  int getTime() {
    if (startTime == null) return 0;
    final elapsedTime = DateTime.now().difference(startTime!).inSeconds;
    return elapsedTime;
  }
}
