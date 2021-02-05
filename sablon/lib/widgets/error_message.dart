import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget errorMessage(BuildContext context, String message) {
  return Flushbar(
    backgroundColor: Colors.red.withOpacity(0.5),
    message: message,
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
  )..show(context);
}
