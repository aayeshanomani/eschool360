import 'package:eschool360/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  User _userFromFirebase(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user{
    return auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebase(user));
    .map(_userFromFirebase);
  }
  
  FirebaseAuth auth = FirebaseAuth.instance;
  signin(String username, String password) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: username + '@school.com', password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async
  {
    try
    {
      return await auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
}
