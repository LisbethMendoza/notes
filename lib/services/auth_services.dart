import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign In (Entrar)
  Future<User?> singInWithEmailAndPassWord(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

   //Sign Up (Registrar)
  Future<User?> registerWithEmailAndPassWord(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

    //Sign out (Salir)
      Future<void> signOut() async {
        try {
          return await _auth.signOut();
        } catch (e) {
          print(e.toString());
          return null;
        }
      }

  signInWithEmailAndPassword(String text, String text2) {}

}
