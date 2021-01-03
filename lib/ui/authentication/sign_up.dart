import 'package:flutter/material.dart';
import 'package:one/service/authentication/authentication_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/shared/button/authentication_button.dart';
import 'package:one/shared/decoration/text_form_field_custom.dart';
import 'package:one/shared/validator/validator_custom.dart';
import 'package:one/ui/authentication/authentication_wigets/sign_up_messages.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

/*User Sign In Form*/
class SignUp extends StatefulWidget {

  /*switches between Sign In and Sign Up View*/
  final Function toggleView;

  SignUp({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  final AuthenticationService _authenticationService = AuthenticationService();

  /*Sign In Form key*/
  final _signInFormKey = GlobalKey<FormState>();

  /*Form fields*/
  String _email = '';
  String _password = '';
  String _displayName = '';
  bool _privacyPolicy=false;

  /*Sign In error message*/
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _signInFormKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: SizedBox(
                      width: 100,
                      child: Image.asset('assets/logo/logo_text.png')),
                ),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                /*Sign Up Messages */
                SignUpMessages(),
                /*Sign Up Text Form Fields */
                TextFormFieldCustom().textFormFieldAuthentication(setDisplayName,
                    ValidatorCustom(context).validateUsername, AppLocalization.of(context).usernamePlaceholder),
                TextFormFieldCustom().textFormFieldAuthentication(setEmail,
                    ValidatorCustom(context).validateEmail, AppLocalization.of(context).emailPlaceholder),
                TextFormFieldCustom().textFormFieldAuthentication(
                    setPassword, ValidatorCustom(context).validatePassword, AppLocalization.of(context).passwordPlaceholder,
                    obscureText: true),
                TextFormFieldCustom().textFormFieldAuthentication(
                    null, ValidatorCustom(context).validatePasswordConfirm, AppLocalization.of(context).confirmPasswordPlaceholder,
                    obscureText: true, validatorCompareString: _password),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.5),
                      child: Checkbox(
                        value: false,
                        onChanged: (value) {
                          setState(() {
                            _privacyPolicy=value;
                          });
                        } ,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,4.5,0,4.5),
                      child: Text(AppLocalization.of(context).acceptPlaceholder),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,4.5,4.5,4.5),
                      child: InkWell(
                        child: Text(AppLocalization.of(context).privacyPolicyPlaceholder),
                        onTap: () => launch('https://www.freeprivacypolicy.com/live/d726f50b-f379-4cd7-b0bc-36bb8d8bca00'),
                      ),
                    )
                  ],
                ),
                /*Sign Up Buttons*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AuthenticationButton().buttonIcon(
                        signUpOnPressed, AppLocalization.of(context).registerPlaceholder, Icon(Icons.login)),
                    AuthenticationButton()
                        .button(widget.toggleView, AppLocalization.of(context).logInPlaceholder),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//Begin sign up with email and password process
  signUpOnPressed() async {
    if (_signInFormKey.currentState.validate() && _privacyPolicy==true) {
      dynamic result = await _authenticationService.signUpWithEmailAndPassword(
          _email, _password,_displayName);
      if (result == null) {
        setState(() {
          _errorMessage = AppLocalization.of(context).errorSignUpCredentials;
        });
      } else {
        Toast.show(AppLocalization.of(context).registrationSuccessfulToast, context);
      }
    }
  }

  setEmail(String email) {
    setState(() {
      _email = email;
    });
  }

  setPassword(String password) {
    setState(() {
      _password = password;
    });
  }

  setDisplayName(String displayName) {
    setState(() {
      _displayName = displayName;
    });
  }
}
