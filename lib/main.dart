import 'package:flutter/material.dart';
import 'package:tervu/helper/functions.dart';
import 'package:tervu/views/home.dart';
import 'package:tervu/views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  bool _isLoggedIn = false;

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  checkUserLoggedIn()async{
    HelperFunctions.getUserLogin().then((value){
      setState(() {
        _isLoggedIn = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_isLoggedIn ?? false) ? Home() : SignIn(),
    );
  }
}

