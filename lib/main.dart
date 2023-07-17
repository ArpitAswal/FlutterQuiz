import 'package:clonequiz/playQuiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:websafe_svg/websafe_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCQ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        appBarTheme: const AppBarTheme(elevation: 0),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static TextEditingController name= TextEditingController();
  TextEditingController mail= TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   name.text='';
   mail.text='';
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: () async{
      SystemNavigator.pop();
      return true;
    },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Center(
            child: Stack(
              children: [
                Center(child: WebsafeSvg.asset("assets/bg.svg", fit: BoxFit.cover)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70,),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Let's Play Quiz",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Enter your informations below",style: TextStyle(color:Colors.white,fontSize: 15),),
                    ),
                    const SizedBox(height: 80,),
                    Center(
                      child: SizedBox(width: 350,
                        child: TextField(
                          controller: name,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white54,
                            labelText: "Enter your name",
                            labelStyle: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.w700),
                            hintText: "Full Name",
                            enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide:BorderSide(width: 2,color: Colors.black) ),
                            focusedBorder: OutlineInputBorder(borderSide:
                            BorderSide(width: 2,color:Colors.blue),
                                borderRadius: BorderRadius.all(Radius.circular(12))),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height:25),
                    Center(
                      child: SizedBox(width: 350,
                        child: TextField(
                          controller: mail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white54,
                              labelText: "Enter your e-mail",
                              labelStyle: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.w700),
                              hintText: "E-Mail",
                              enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                                  borderSide:BorderSide(width: 2,color: Colors.black) ),
                              focusedBorder: OutlineInputBorder(borderSide:
                              BorderSide(width: 2,color:Colors.blue),
                                  borderRadius: BorderRadius.all(Radius.circular(12)))
                          ),
                        ),

                      ),
                    ),
                    const SizedBox(height:25),

                    InkWell(
                      onTap: (){
                        debugPrint("${Text(name.text.toString())}");
                        if(name.text.isEmpty || mail.text.isEmpty){
                          var snackbar= const SnackBar(content: Text('please filled the both textfields'));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        else {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => const PlayQuiz()),);
                        }
                        },
                      child: Center(
                        child: Container(
                          width:350,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8), // 15
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: const Text(
                              " START ",
                              style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 115),
                    Center(child: Image.asset('assets/quizPicture.jpg',width:370))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



