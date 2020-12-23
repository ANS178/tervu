import 'package:flutter/material.dart';
import 'package:tervu/services/database.dart';
import 'package:tervu/views/create_quiz.dart';
import 'package:tervu/views/play_quiz.dart';
import 'package:tervu/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: StreamBuilder (
        stream: quizStream,
        builder: (context,snapshot){
          return snapshot.data == null
              ? Container(): ListView.builder(
                itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                    return QuizTile(
                      imageUrl: snapshot.data.documents[index].data["quizImgurl"],
                      description: snapshot.data.documents[index].data["quizDescription"],
                      title: snapshot.data.documents[index].data["quizTitle"],
                      quizId: snapshot.data.documents[index].data["quizId"],
                    );
                  },
          );
        },
      ),
    );
  }
  void initState(){
    databaseService.getQuizData().then((val){
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        brightness: Brightness.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (contect) => CreateQuiz()
          ));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String description;
  final String quizId;

  QuizTile({@required this.imageUrl, @required this.title, @required this.description, @required this.quizId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PlayQuiz(
            quizId
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl, width: MediaQuery.of(context).size.width-48, fit: BoxFit.cover,)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),

              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),),
                  SizedBox(height: 6,),
                  Text(description, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}

