import 'package:flutter/material.dart';
import 'package:one/service/authentication/authentication_service.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/shared/button/authentication_button.dart';
import 'package:one/shared/decoration/text_form_field_custom.dart';
import 'package:one/shared/validator/validator_custom.dart';

class ChooseDisplayNameDialog {
  final _formKey = GlobalKey<FormState>();
  String _displayName='';

  void showAddPointDialog(BuildContext context, AuthenticationService _authenticationService) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset('assets/logo/logo_no_text.png'),
                Text(globals.chooseUsernameDialogTitle),
              ],
            ),
            content: Column(
              children: [
                Text(globals.chooseUsernameDialogMessage),
                Form(
                  key: _formKey,
                  child: TextFormFieldCustom().textFormFieldAuthentication(setDisplayName, ValidatorCustom().validateUsername, 'Username'),
                )
              ],
            ),
            actions: <Widget>[
              AuthenticationButton().buttonIcon(_confirmUsernameButtonOnPressed, text, icon),
              new FlatButton(
                  onPressed: () async {
                    _authenticationService.signInWithGoogle(_displayName);
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }
  
  void _confirmUsernameCallback(){
    _confirmUsernameButtonOnPressed(authenticationService, context)
  }

  void _confirmUsernameButtonOnPressed(AuthenticationService authenticationService, BuildContext context) {
    authenticationService.signInWithGoogle(_displayName);
    Navigator.pop(context);
  }


  setDisplayName(String displayName){
    _displayName=displayName;
  }
}
