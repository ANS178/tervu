import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:tervu/services/database.dart';
import 'package:tervu/views/addquestion.dart';
import 'package:tervu/widgets/widgets.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  @override
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizdescription, quizId;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDescription" : quizdescription
      };
      await databaseService.addQuizData(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => AddQuestion(
                quizId
              )
          ));
        });
      });
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ): Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 50,),

              TextFormField(
                validator: (val) => val.isEmpty ?  "Enter Quiz Image Url" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Image Url"
                ),
                onChanged:(val){
                  quizImageUrl = val;
                },
              ),
              SizedBox(height: 6,),

              TextFormField(
                validator: (val) => val.isEmpty ?  "Enter Quiz Title" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Title"
                ),
                onChanged:(val){
                  quizTitle = val;
                },
              ),
              SizedBox(height: 6,),

              TextFormField(
                validator: (val) => val.isEmpty ?  "Enter Quiz Description" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Description"
                ),
                onChanged:(val){
                  quizdescription = val;
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  createQuizOnline();
                },
                child: blueButton(
                  context: context,
                  label: "Create Quiz"
                )),

              SizedBox(height: 60,),
            ],
          ),
        ),
      ),
    );
  }
}
