import 'package:flutter/material.dart';
import 'package:one/information/globals.dart' as globals;


//Buttons used during authentication
class AuthenticationButton {

  RaisedButton button(Function onPressed, String text,{bool background=false}) {
    return RaisedButton(
      color: background ? globals.notSoGreen :Colors.white,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: globals.green),
      ),
    );
  }

  RaisedButton buttonIcon(Function onPressed, String text,Icon icon,{bool background=false}) {
    return RaisedButton.icon(
    color: background ? globals.notSoGreen :Colors.white,
      icon: icon,
      onPressed: onPressed,
      label: Text(
        text,
        style: TextStyle(color: background ? globals.greenAsGreenGreenCanBe :Colors.lightGreen),
      ),
    );
  }

}