import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quizWorker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizWorker quizWrkr = QuizWorker();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}


class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}




class _QuizPageState extends State<QuizPage> {

  List<Widget> scoreKeeper = [];

  void answerchecker (bool userPickedanswer) {
    bool correctAnswer = quizWrkr.getAnswer();
    setState(() {

      if(quizWrkr.isFinished() == true){
        Alert(
          context: context,
          type: AlertType.error,
          title: "STOP",
          desc: "You have reached the end",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();

        quizWrkr.resetNumber();
        scoreKeeper = [];

      }else{
        if(userPickedanswer == correctAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red,));

        }
        quizWrkr.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 5,
            child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              quizWrkr.getQuestionTxt(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: FlatButton(
              onPressed: (){
                answerchecker(true);
              },
              color: Colors.green,
              child: Text(
                'True',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              ),
        ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: FlatButton(
              onPressed: (){
                answerchecker(false);
              },
              color: Colors.red,
              child: Text(
                'False',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
