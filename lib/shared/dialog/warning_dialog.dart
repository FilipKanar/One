
import 'package:flutter/material.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/shared/button/authentication_button.dart';

/*Displays warning
* */
class WarningDialog {
  void showWarningDialog(
      BuildContext context, String titleText, String messageText) {

    void _confirmButtonOnPressed(){
      Navigator.pop(context);
    }

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Container(
                  width: 50,
                  child: Image.asset('assets/logo/logo_no_text.png'),
                ),
                Text(titleText,),
              ],
            ),
            content: SingleChildScrollView(
              child: Text(messageText),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: AuthenticationButton().button(
                  _confirmButtonOnPressed,
                  'OK',
                  background: true,
                ),
              ),
            ],
          );
        });
  }
}
