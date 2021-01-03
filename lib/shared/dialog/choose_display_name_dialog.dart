import 'package:flutter/material.dart';
import 'package:one/service/authentication/authentication_service.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/shared/button/authentication_button.dart';
import 'package:one/shared/decoration/text_form_field_custom.dart';
import 'package:one/shared/validator/validator_custom.dart';

/*Dialog displayed if sign up method is different than email and password
* */
class ChooseDisplayNameDialog {
  final _formKey = GlobalKey<FormState>();
  String _displayName = '';

  void showChangeUsernameDialog(
      BuildContext context, AuthenticationService _authenticationService) {
    void _confirmUsernameButtonOnPressed(
        AuthenticationService authenticationService, BuildContext context) {
      authenticationService.signInWithGoogle();
      Navigator.pop(context);
    }

    void _confirmUsernameCallback() {
      _confirmUsernameButtonOnPressed(_authenticationService, context);
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
                Text(AppLocalization.of(context).changeUsernamePlaceholder),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 9),
                    child: Text(AppLocalization.of(context).chooseUsernameDialogMessage),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormFieldCustom().textFormFieldAuthentication(
                        _setDisplayName,
                        ValidatorCustom(context).validateUsername,
                        AppLocalization.of(context).usernamePlaceholder),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: AuthenticationButton().buttonIcon(
                  _confirmUsernameCallback,
                  AppLocalization.of(context).continuePlaceholder,
                  Icon(Icons.login, color: globals.greenerThanGreenAsGreenGreenCanBe,),
                  background: true,
                ),
              ),
              AuthenticationButton().button(
                    () => Navigator.pop(context),
                AppLocalization.of(context).cancelPlaceholder,
              ),

            ],
          );
        });
  }

  _setDisplayName(String displayName) {
    _displayName = displayName;
  }
}
