import 'package:flutter/material.dart';
import 'package:clonequiz/resultPage.dart';
import 'package:clonequiz/questions.dart';
class Play {
  String question;
  List<String> answer;

  Play({required this.question, required this.answer});
}


class PlayQuiz extends StatefulWidget {
  const PlayQuiz({super.key});



  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {

  PageController? _controller;
  String ans = "";
  List? rightanswer = List.filled(10, false, growable: false);
  static int boolindex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: PageView.builder(
        controller: _controller,
        onPageChanged: (page) {
            setState(() {
              boolindex=page;
            });

        },
        itemCount: questions.length,
        itemBuilder: (context,index){
          return Stack(
            children:[
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                "Question ${index + 1}/10",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            color: Colors.black,
            ),
            const SizedBox(
            height: 20.0,
            ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                  child: Text("${questions[index].question}",style: const TextStyle(
                  color: Colors.red,
                  fontSize: 22.0,
              ),
                  textAlign: TextAlign.center,
              ),
                ),
              for(int i=0; i< questions[index].answers.length;i++)
                Row(
          children:[
               Radio(
               fillColor: const MaterialStatePropertyAll<Color>(Colors.blue),
                   value: questions[index].answers.keys.toList()[i],
               groupValue: ans,
               onChanged: (String? value){
                 setState(() {
                   ans=value!;
                   if(ans==questions[index].answers.keys.toList()[i] && questions[index].answers.values.toList()[i] ==true ){
                     rightanswer?[boolindex]=true;
                   }
                   else{
                     rightanswer?[boolindex]=false;
                   }
                 });
                 debugPrint("ans=$ans");
                 debugPrint("boolindex=$boolindex");

               }
               ),
               Expanded(child: Text(questions[index].answers.keys.toList()[i],textAlign: TextAlign.center,style: const TextStyle(fontSize: 21,color: Colors.blue))),
                        ],
                      ),
               ]   ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 14),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_controller?.page?.toInt()==questions.length-1){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScoreScreen(rightanswer!)));
                      }
                      else{
                        _controller!.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeInExpo);
                      }
                    },
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.red),
                      shadowColor: MaterialStateProperty.all(Colors.black54),
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
                    child: (index<9)?const Text('Next'):const Text('Submit'),
                  ),
                ),
              )
          ]
          );
        })
    );
  }
}
