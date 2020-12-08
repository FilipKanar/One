import 'package:flutter/material.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/model/user/user_from_firebase_user.dart';
import 'package:one/service/authentication/authentication_service.dart';
import 'package:one/service/user_data/user_data_service.dart';
import 'package:one/ui/home/screens/profile.dart';
import 'package:one/ui/home/screens/ranking.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatelessWidget {
  final String title;

  //Show actions
  final bool showRanking;
  final bool showProfile;
  final bool showLogout;

  AppBarCustom({
    this.title = 'One',
    this.showLogout = false,
    this.showProfile = false,
    this.showRanking = false,
  });

  @override
  Widget build(BuildContext context) {
    UserFromFirebaseUser userFromFirebaseUser = Provider.of<UserFromFirebaseUser>(context);
    return AppBar(
      leading: FlatButton(
        onPressed: () => Navigator.maybePop(context),
        child: Image.asset(
          'assets/logo/logo_no_text.png',
          height: 50,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: globals.appBarTitleColor,
        ),
      ),
      backgroundColor: globals.appBarColor,
      actions: [
        showRanking == true
            ? IconButton(
                icon: Icon(
                  Icons.bar_chart_rounded,
                  color: globals.appBarIconColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          StreamProvider.value(
                            value: UserDataService().users,
                          ),
                          StreamProvider.value(
                              value: UserDataService(userId: userFromFirebaseUser.uid)
                                  .userData)
                        ],
                        child: Ranking(),
                      ),
                    ),
                  );
                },
              )
            : Container(),
        showProfile == true
            ? IconButton(
                icon: Icon(Icons.assignment_ind_outlined),
                color: globals.appBarIconColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StreamProvider.value(
                          value: UserDataService(userId: userFromFirebaseUser.uid)
                              .userData,
                          child: Profile()),
                    ),
                  );
                },
              )
            : Container(),
        showLogout == true
            ? IconButton(
                icon: Icon(Icons.logout),
                color: globals.appBarIconColor,
                onPressed: () async {
                  AuthenticationService().signOut();
                })
            : Container(),
      ],
    );
  }
}
