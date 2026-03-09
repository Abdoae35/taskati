import 'package:flutter/material.dart';

Future<dynamic> pushTo(BuildContext context, Widget targetScreen) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => targetScreen),
  );
}


Future<dynamic> pushReplaceMent(BuildContext context, Widget targetScreen) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => targetScreen),
  );
}

Future<dynamic> pushRemoveAll(BuildContext context, Widget targetScreen) {
 return Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => targetScreen),
  (route) => false, 
);
}