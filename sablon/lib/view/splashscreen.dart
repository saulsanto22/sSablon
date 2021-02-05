import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sablon/view/pesan.dart';
import 'dasboard.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Nyablon Apps",
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
