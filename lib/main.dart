import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one/service/authentication/authentication_service.dart';
import 'package:one/ui/wrapper.dart';
import 'package:provider/provider.dart';

import 'model/user/user_from_firebase_user.dart';

void main() async {
  /*
  WidgetsFlutterBinding -  interacts with Flutter Engine
  WidgetsFlutterBinding.ensureInitialized()  - awaiting async
  Firebase.initializeApp() - calls native code to initialize Firebase. Using Platform Channels
   */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
/*
provides User Authentication Stream to verify identity
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserFromFirebaseUser>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //checks authentication status with provided stream value
        home: Wrapper(),
      ),
    );
  }
}