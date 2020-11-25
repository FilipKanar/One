import 'package:flutter/material.dart';
import 'package:one/ui/authentication/sign_in.dart';
import 'package:one/ui/authentication/sign_up.dart';

class AuthenticateWrapper extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<AuthenticateWrapper> {
  bool _showSignIn = true;

  void _changeSignInSignUp() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }
//Shows Sing In/ Sign Up widget depending on _showSignIn bool value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _showSignIn
            ? SignIn(
                toggleView: _changeSignInSignUp,
              )
            : SignUp(
                toggleView: _changeSignInSignUp,
              ),);
  }
}
