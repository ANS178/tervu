
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tervu/models/user.dart';

class AuthService{

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid):null;
  }

  Future signInEmailAndPassword(String email, String password) async {

    try{
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async{

    try{
      AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async{

    try{
      return await _firebaseAuth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }



}