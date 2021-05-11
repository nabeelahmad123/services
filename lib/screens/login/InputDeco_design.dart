import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(IconData icons, String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    hintStyle: TextStyle(color: Colors.black54),
    prefixIcon: Icon(
      icons,
    ),
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(30.0),
    //   borderSide: BorderSide(color: Colors.white, width: 1),
    // ),
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(30.0),
    //   borderSide: BorderSide(
    //     color: Colors.black,
    //     width: 1,
    //   ),
    // ),
    // enabledBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(30.0),
    //   borderSide: BorderSide(
    //     color: Colors.black,
    //     width: 1,
    //   ),
    // ),
  );
}
