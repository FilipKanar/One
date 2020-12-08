import 'package:flutter/material.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/model/user/user_from_firebase_user.dart';
import 'package:one/service/user_data/user_data_service.dart';
import 'package:one/ui/authentication/authenticate_wrapper.dart';
import 'package:one/ui/home/home_view.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    //variable changes is authentication state changes
    final userFromFirebaseUser = Provider.of<UserFromFirebaseUser>(context);
    return userFromFirebaseUser == null
        ? AuthenticateWrapper()
        : StreamProvider<UserData>.value(
            value: UserDataService(userId: userFromFirebaseUser.uid).userData,
            child: HomeView(),
          );
  }
}
