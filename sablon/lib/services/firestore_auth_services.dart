import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sablon/model/app_user.dart';

class FirestoreAuthServices {
  //* instance
  static var _userCollection = FirebaseFirestore.instance.collection('users');
  //* store user data
  static Future<void> storeUserData(AppUser appUser) async {
    _userCollection.doc(appUser.id).set({
      'email': appUser.email,
      'username': appUser.username,
      'profile_picture': appUser.profilePicture ?? '',
    });
  }

  //* get user data
  static Future<AppUser> getUserData(String uid) async {
    var _result = await _userCollection.doc(uid).get();
    return AppUser(
      id: uid,
      email: _result.data()['email'],
      username: _result.data()['username'],
      profilePicture: _result.data()['profile_picture'],
    );
  }
}
