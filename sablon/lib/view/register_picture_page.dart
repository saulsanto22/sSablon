import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sablon/config/base_config.dart';
import 'package:sablon/model/register_user.dart';
import 'package:sablon/view/register_confirmation_page.dart';
import 'package:sablon/widgets/pick_image.dart';

class RegisterPicturePage extends StatefulWidget {
  @override
  _RegisterPicturePageState createState() => _RegisterPicturePageState();
}

class _RegisterPicturePageState extends State<RegisterPicturePage> {
  File _userPicture;
  RegisterUser registerUser;
  @override
  Widget build(BuildContext context) {
    registerUser = ModalRoute.of(context).settings.arguments;
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
                SizedBox(height: 40),
                _selectPicture(context),
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
              SizedBox(height: 10),
              Text(
                'Costumer',
                style: BaseConfig.textStyle.copyWith(
                  fontSize: 22,
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

  Widget _selectPicture(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Photo Costumer',
          style: BaseConfig.textStyle.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 320,
          width: 200,
          child: Center(
            child: Container(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: _userPicture == null
                          ? Colors.transparent
                          : BaseConfig.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        shape: BoxShape.circle,
                        image: _userPicture != null
                            ? DecorationImage(
                                image: FileImage(_userPicture),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _userPicture == null
                          ? Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 50,
                            )
                          : null,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: _userPicture == null
                            ? BaseConfig.primaryColor
                            : Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: IconButton(
                          icon: _userPicture == null
                              ? Icon(Icons.add, color: Colors.white)
                              : Icon(Icons.cancel, color: Colors.white),
                          onPressed: () {
                            if (_userPicture == null) {
                              pickImage(
                                  context: context,
                                  image: (file) {
                                    setState(() {
                                      _userPicture = file;
                                    });
                                  });
                            } else {
                              setState(() {
                                _userPicture = null;
                              });
                            }
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 70),
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
                onPressed: () => Navigator.pop(context),
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
                onPressed: _next,
                child: Text(
                  'SELANJUTNYA',
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

  void _next() {
    // registerUser.userPicture = _userPicture;
    Map<String, dynamic> registerData = {
      'register_user': registerUser,
      'register_picture': _userPicture,
    };
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, an, san) {
          return RegisterConfirmationPage();
        },
        transitionsBuilder: (context, an, san, ch) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1, 0),
              end: Offset.zero,
            ).animate(an),
            child: ch,
          );
        },
        settings: RouteSettings(arguments: registerData),
      ),
    );
  }
}
