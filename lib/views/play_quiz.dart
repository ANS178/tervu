import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tervu/models/question_model.dart';
import 'package:tervu/services/database.dart';
import 'package:tervu/views/results.dart';
import 'package:tervu/widgets/quiz_play_widgets.dart';
import 'package:tervu/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {

  final String quizId;

  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionSnapshot;

  QuestionModel getQuestionModelFromDataSnapShot(DocumentSnapshot questionSnapshot){
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"]
    ];

    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered =false;

    return questionModel;
  }

  void initState(){
   databaseService.getQuizQNA(widget.quizId).then((value){
     questionSnapshot = value;
     _notAttempted =0;
     _correct = 0;
     _incorrect = 0;
     total = questionSnapshot.documents.length;


     setState(() {

     });
    });
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black26,
        ),
        centerTitle: true,
        brightness: Brightness.light,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              questionSnapshot== null ?
                  Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ) :
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: questionSnapshot.documents.length,
                    itemBuilder: (context, index){
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromDataSnapShot(questionSnapshot.documents[index]),
                        index: index,
                      );
                    },
                  )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _correct,
              total: total,
            )
          ));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {

  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Q${widget.index+1}: ${widget.questionModel.question}", style: TextStyle(fontSize: 17, color: Colors.black87),),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option1 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;

                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option2 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;

                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option3 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;

                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option4 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;

                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
