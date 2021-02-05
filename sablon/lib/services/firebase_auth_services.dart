import 'package:firebase_auth/firebase_auth.dart';
import 'package:sablon/model/app_user.dart';
import 'package:sablon/model/register_user.dart';

import 'package:sablon/model/response/auth_result.dart';

import 'firestore_auth_services.dart';

class FirebaseAuthServices {
  //* Instance
  static var _auth = FirebaseAuth.instance;
  //* Stream user state
  static Stream<User> get userStream => _auth.authStateChanges();
  //* register
  static Future<AuthResult> register(RegisterUser registerUser) async {
    try {
      var _result = await _auth.createUserWithEmailAndPassword(
        email: registerUser.email,
        password: registerUser.password,
      );
      AppUser appUser = AppUser(
        id: _result.user.uid,
        email: _result.user.email,
        username: registerUser.username,
        profilePicture: registerUser.profilePicture,
      );
      await FirestoreAuthServices.storeUserData(appUser);

      return AuthResult(uid: _result.user.uid);
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: e.message);
    }
  }

  //* login
  static Future<AuthResult> login(String email, String password) async {
    try {
      var _result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(uid: _result.user.uid);
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: e.message);
    }
  }

  //* logout
  static Future<void> logout() async {
    await _auth.signOut();
  }
}
