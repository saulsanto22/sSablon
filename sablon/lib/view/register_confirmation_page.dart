import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sablon/config/base_config.dart';
import 'package:sablon/model/register_user.dart';
import 'package:sablon/services/firebase_auth_services.dart';
import 'package:sablon/view/dasboard.dart';
import 'package:sablon/widgets/error_message.dart';

class RegisterConfirmationPage extends StatefulWidget {
  @override
  _RegisterConfirmationPageState createState() =>
      _RegisterConfirmationPageState();
}

class _RegisterConfirmationPageState extends State<RegisterConfirmationPage> {
  RegisterUser registerUser;
  File profilePicture;
  var _tryRegister = false;
  @override
  Widget build(BuildContext context) {
    var registerData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    registerUser = registerData['register_user'];
    profilePicture = registerData['register_picture'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(context),
                SizedBox(height: 30),
                _userData(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pendaftaran',
                style: BaseConfig.textStyle.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Image(
            image: AssetImage('assets/images/background_image.png'),
            height: 150,
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget _userData(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: Container(
            width: BaseConfig.deviceWidth(context) * 0.7,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Data Pengguna',
                  style: BaseConfig.textStyle.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Divider(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: profilePicture != null
                        ? BaseConfig.primaryColor
                        : Colors.transparent,
                  ),
                  child: Container(
                    height: 130,
                    width: 130,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      shape: BoxShape.circle,
                      image: profilePicture != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(profilePicture),
                            )
                          : null,
                    ),
                    child: profilePicture == null
                        ? Icon(
                            Icons.person,
                            color: Colors.blueGrey[200],
                            size: 50,
                          )
                        : null,
                  ),
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Email',
                      style: BaseConfig.textStyle,
                    ),
                    Text(
                      '${registerUser.email}',
                      style: BaseConfig.textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Usermame',
                      style: BaseConfig.textStyle,
                    ),
                    Text(
                      '${registerUser.username}',
                      style: BaseConfig.textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
              width: BaseConfig.deviceWidth(context) * 0.35,
              child: OutlineButton(
                color: BaseConfig.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: _tryRegister ? () {} : () => Navigator.pop(context),
                child: Text(
                  'KEMBALI',
                  style: BaseConfig.textStyle.copyWith(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: BaseConfig.deviceWidth(context) * 0.35,
              child: RaisedButton(
                color: BaseConfig.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: _register,
                child: _tryRegister
                    ? SpinKitThreeBounce(
                        color: Colors.white,
                        size: 15,
                      )
                    : Text(
                        'KONFIRMASI',
                        style: BaseConfig.textStyle.copyWith(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _register() async {
    setState(() => _tryRegister = true);
    BaseConfig.imageToUpload = profilePicture;
    var _result = await FirebaseAuthServices.register(registerUser);
    setState(() => _tryRegister = false);
    if (_result.errorMessage != null) {
      errorMessage(context, _result.errorMessage);
      return;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  }
}
