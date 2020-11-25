import 'package:flutter/material.dart';

class InputDecorationCustom{

  //Input decoration used durin authentication process
  InputDecoration inputDecorationAuthenticate(String hint){
    return InputDecoration(
      hintText: hint,
      fillColor: Colors.white,
      errorMaxLines: 4,
      focusedBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),
        borderSide: BorderSide(
            color: Colors.lightGreen),
      ),
      border: new OutlineInputBorder(
        borderRadius:
        new BorderRadius.circular(9.0),
      ),
    );
  }

}