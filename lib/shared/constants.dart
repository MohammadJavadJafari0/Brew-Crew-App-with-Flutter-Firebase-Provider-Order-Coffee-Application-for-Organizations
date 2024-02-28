import 'package:flutter/material.dart';

//messageColor
Color massagesColor = const Color.fromARGB(255, 144, 15, 6);

//textInputDecoration
const textInputDecoration = InputDecoration(
    hintStyle: TextStyle(color: Colors.black),
    fillColor: Color(0xFFFFCC80),
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE69D45), width: 2.0)));
