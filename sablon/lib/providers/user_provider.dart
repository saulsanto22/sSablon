import 'package:flutter/material.dart';

import 'package:sablon/model/app_user.dart';
import 'package:sablon/services/firestore_auth_services.dart';

class UserProvider extends ChangeNotifier {
  AppUser _appUser;
  AppUser get appUser => _appUser;

  void getUser(String uid) async {
    _appUser = await FirestoreAuthServices.getUserData(uid);
    notifyListeners();
  }

  void updateUser({String username, String profilePicture}) async {
    var _newData = _appUser.copyWith(username, profilePicture);
    _appUser = _newData;
    await FirestoreAuthServices.storeUserData(_newData);
    notifyListeners();
  }

  void clearUser() {
    _appUser = null;
  }
}
