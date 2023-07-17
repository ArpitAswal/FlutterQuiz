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

  int score = 0;
  PageController? _controller;
  bool answered=false;
  int correct=-1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252c4a), //Color(0xFF117eeb);
      body: PageView.builder(
          controller: _controller,
          onPageChanged: (page) {
              setState(() {
                answered = false;
                correct=-1;
              });

          },
          //physics: NeverScrollableScrollPhysics(),
          itemCount: questions.length,
          itemBuilder: (context,index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                "Question ${index + 1}/10",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
            Divider(
            color: Colors.white,
            ),
            SizedBox(
            height: 20.0,
            ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                  child: Text("${questions[index].question}",style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
              ),
                  textAlign: TextAlign.center,
              ),
                ),
              for(int i=0; i< questions[index].answers.length;i++)
                  Container(
                 width: double.infinity,
                 height: 50.0,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                 child: ElevatedButton(
                onPressed: (){
                  correct=i;
                  answered = true;
                  if(questions[index].answers.values.toList()[i]) {
                    score++;
                  }
                  setState(() {

                  });
                  if(_controller?.page?.toInt()==questions.length-1){
                        Navigator.push(
                         context,
                    MaterialPageRoute(
                           builder: (context) => resultPage(score)));
                     }
                   else{
                  _controller!.nextPage(
                  duration: Duration(milliseconds:100 ),
                     curve: Curves.easeInExpo);
                   }
            },
              style: ButtonStyle(
                  backgroundColor: (answered) ? (i==correct) ? (questions[index].answers.values.toList()[i]) ? MaterialStateProperty.all(Color(0xFF31B226)) :
            MaterialStateProperty.all(Color(0xFFE81818)) :  MaterialStateProperty.all(Color(0xf91357de)) :  MaterialStateProperty.all(Color(0xf91357de)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.black54),
                  side: MaterialStateProperty.all(const BorderSide(
                    width: 1.5,
                    color: Colors.white,
                  )),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)
                ))
              ),
               child: Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Text(questions[index].answers.keys.toList()[i],textAlign: TextAlign.center,style: TextStyle(fontSize: 17),),
               )
            )),
              SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () {
                    if(_controller?.page?.toInt()==questions.length-1){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => resultPage(score)));
                    }
                    else{
                      _controller!.nextPage(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeInExpo);

                    }
                  },
                  child: (index<9)?Text('Next'):Text('Submit'),
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
                )
            ],
            );
          })
    );
  }
}
