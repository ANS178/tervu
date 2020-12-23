import 'package:flutter/material.dart';
import 'package:tervu/helper/functions.dart';
import 'package:tervu/services/auth.dart';
import 'package:tervu/views/home.dart';
import 'package:tervu/views/signup.dart';
import 'package:tervu/widgets/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override

  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  signIn() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading  = true;
      });

      await authService.signInEmailAndPassword(email, password).then((value){
        if(value!=null){
          setState(() {
            _isLoading  = false;
          });

          HelperFunctions.saveUserLogin(isLoggedIn: true);

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Home()
          ));
        }
      });


    }
  }

  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val){return val.isEmpty ?  "Enter Email id" : null;},
                decoration: InputDecoration(
                  hintText: "Email"
                ),
                onChanged:(val){
                  email = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                obscureText: true,
                validator: (val){return val.isEmpty ?  "Enter Password" : null;},
                decoration: InputDecoration(
                    hintText: "Password"
                ),
                onChanged:(val){
                  password = val;
                },
              ),
              SizedBox(height: 24,),
              GestureDetector(
                onTap:() {
                  signIn();
                },
                child: blueButton(
                  context: context,
                  label: "Sign In"
                ),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account?  ", style: TextStyle(fontSize: 15.5),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignUp()
                        ));
                      },
                      child: Text("Sign Up", style: TextStyle(fontSize: 15.5, decoration: TextDecoration.underline)))
                ],
              ),

              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
