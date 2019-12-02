import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:my_utils_app/config/config.dart';
import 'package:my_utils_app/main.dart';
void main() async {
  Config.env = Env.PRE;
   SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  return runApp(MyApp());
}