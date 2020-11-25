import 'package:flutter/material.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/ui/home/screens/ranking.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatelessWidget{
  final String title;

  //Show actions
  final bool showRanking;
  final bool showProfile;
  final bool showLogout;

  AppBarCustom({this.title='One',this.showLogout=true,this.showProfile=true,this.showRanking=true,});

  @override
  Widget build(BuildContext context){
    return AppBar(
      title: Row(children: [Container(child: Image.asset('assets/logo/logo_no_text.png',height: 50,),),Text(title),],),
      backgroundColor: globals.appBarColor,
      actions: [
        showRanking == true
            ? IconButton(
          icon: Icon(Icons.bar_chart_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Ranking(),
              ),
            );
          },
        )
            : Container(),
        /*showProfile == true
            ? IconButton(
          icon: Icon(Icons.assignment_ind_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    StreamProvider.value(value: UserService(uid: user.uid).user),
                  ],
                  child: Profile(),
                ),
              ),
            );
          },
        )
            : Container(),
        showLogout == true
            ? IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              AuthenticationService().logOut();
            })
            : Container(),*/
      ],
    );
  }
}