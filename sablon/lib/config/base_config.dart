import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseConfig {
  //*
  static File imageToUpload;

  //* Color
  static Color primaryColor = Color(0xFF63B3FF);
  static Color primaryDark = Color(0xFF325E8C);
  static Color accentColor = Color(0xFFFFCE63);

  //* Device
  static deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static deviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  //* TextStyle
  static TextStyle textStyle = GoogleFonts.openSans().copyWith(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );

  static TextStyle numberStyle = GoogleFonts.roboto().copyWith(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );

  static void statusBarConfig() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // Android
        statusBarIconBrightness: Brightness.dark,
        // IOS
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  static void stayPotrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
}
