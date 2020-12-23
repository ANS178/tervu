import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String UserLoggedInKey = "USERLOGGEDINKEY";

  static saveUserLogin({@required bool isLoggedIn}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(UserLoggedInKey, isLoggedIn);
  }

  static Future<bool> getUserLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(UserLoggedInKey);
  }
}