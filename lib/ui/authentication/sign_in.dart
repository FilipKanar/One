import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:one/service/authentication/authentication_service.dart';
import 'package:one/shared/button/authentication_button.dart';
import 'package:one/shared/decoration/text_form_field_custom.dart';
import 'package:one/shared/validator/validator_custom.dart';
import 'package:toast/toast.dart';
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
                    ValidatorCustom().validateEmail, 'Email'),
                TextFormFieldCustom().textFormFieldAuthentication(
                    _setPassword, ValidatorCustom().validatePassword, 'Password',
                    obscureText: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AuthenticationButton().button(_overviewOnPressed, 'Overview'),
                    AuthenticationButton().buttonIcon(
                        _signInOnPressed, 'Log In', Icon(Icons.login)),
                    AuthenticationButton()
                        .button(widget.toggleView, 'Register'),
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
          _errorMessage = 'Could not sign in with those credentials.';
        });
      } else {
        Toast.show('Login Successful', context);
      }
    }
  }
  //Begin Sign In with google process
  _signInWithGoogleOnPressed() async {
    await _authenticationService.signInWithGoogle();
  }

  _overviewOnPressed() async {
    dynamic result = await _authenticationService.signInWithEmailAndPassword(testUserData.testUserEmail, testUserData.testUserPassword);
    if (result == null) {
      setState(() {
        _errorMessage = 'Could not sign in to test account.';
      });
    } else {
      Toast.show('Login Successful', context);
    }
  }

  _setEmail(String email) {
      _email = email;
  }

  _setPassword(String password) {
      _password = password;
  }
}
