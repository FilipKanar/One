import 'package:flutter/material.dart';
import 'package:one/model/user/user_from_firebase_user.dart';
import 'package:one/service/authentication/authentication_service.dart';
import 'package:provider/provider.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  int userPositioninRanking;

  @override
  Widget build(BuildContext context) {
    UserFromFirebaseUser user = Provider.of<UserFromFirebaseUser>(context);
    return Scaffold(
      body: Column(
        children: [
          FlatButton(onPressed: AuthenticationService().signOut, child: Text('Sign Out'),),
          Text(user.uid??'default'),
        ],
      ),
    );
  }
}
