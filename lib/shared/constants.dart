import 'package:flutter/material.dart';

//messageColor
Color massagesColor = Color.fromARGB(255, 246, 46, 46);
Color userTextColor = const Color.fromARGB(255, 69, 52, 46);

//textInputDecoration
const textInputDecoration = InputDecoration(
    hintStyle: TextStyle(color: Colors.black),
    errorStyle:
        TextStyle(color: Color.fromARGB(255, 224, 150, 60), fontSize: 16.0),
    fillColor: Color(0xFFFFCC80),
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE69D45), width: 2.0)));

//Validating Email Form
bool validateEmail(String email) {
  RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regExp.hasMatch(email);
}
