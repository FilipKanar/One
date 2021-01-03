import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:one/service/authentication/authentication_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/shared/button/authentication_button.dart';
import 'package:one/shared/decoration/text_form_field_custom.dart';
import 'package:one/shared/validator/validator_custom.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:one/information/test_user_data.dart' as testUserData;

/*User Sign In Form*/
class SignIn extends StatefulWidget {
  /*switches between Sign In and Sign Up View*/
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthenticationService _authenticationService = AuthenticationService();

  /*Sign In Form key*/
  final _signInFormKey = GlobalKey<FormState>();

  /*Form fields*/
  String _email = '';
  String _password = '';
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
                  height: 100,
                  child: Image.asset('assets/logo/logo_text.png'),
                ),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                TextFormFieldCustom().textFormFieldAuthentication(_setEmail,
                    ValidatorCustom(context).validateEmail, AppLocalization.of(context).emailPlaceholder),
                TextFormFieldCustom().textFormFieldAuthentication(
                    _setPassword, ValidatorCustom(context).validatePassword, AppLocalization.of(context).passwordPlaceholder,
                    obscureText: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AuthenticationButton().button(_overviewOnPressed, AppLocalization.of(context).appOverview),
                    AuthenticationButton().buttonIcon(
                        _signInOnPressed, AppLocalization.of(context).logInPlaceholder, Icon(Icons.login)),
                    AuthenticationButton()
                        .button(widget.toggleView, AppLocalization.of(context).registerPlaceholder),
                  ],
                ),
                FlatButton(onPressed: (){
                  setState(() {
                    AppLocalization.load(Locale('pl',''));
                  });
                }, child: Text('Zmiana')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.5),
                      child: Checkbox(
                        value: _privacyPolicy,
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
                GoogleSignInButton(
                  onPressed: _signInWithGoogleOnPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //Begin Sign In with email and password process
  _signInOnPressed() async {
    if (_signInFormKey.currentState.validate()) {
      dynamic result = await _authenticationService.signInWithEmailAndPassword(
          _email, _password);
      if (result == null) {
        setState(() {
          _errorMessage = AppLocalization.of(context).errorSignInCredentials;
        });
      } else {
        Toast.show(AppLocalization.of(context).loginSuccessfulToast, context);
      }
    }
  }
  //Begin Sign In with google process
  _signInWithGoogleOnPressed() async {
    if(_privacyPolicy==false){
      setState(() {
        _errorMessage=AppLocalization.of(context).googlePrivacyPolicyMessage;
      });
    } else {
      await _authenticationService.signInWithGoogle();
    }
  }

  _overviewOnPressed() async {
    dynamic result = await _authenticationService.signInWithEmailAndPassword(testUserData.testUserEmail, testUserData.testUserPassword);
    if (result == null) {
      setState(() {
        _errorMessage = AppLocalization.of(context).testUserLogInErrorMessage;
      });
    } else {
      Toast.show(AppLocalization.of(context).loginSuccessfulToast, context);
    }
  }

  _setEmail(String email) {
      _email = email;
  }

  _setPassword(String password) {
      _password = password;
  }
}
