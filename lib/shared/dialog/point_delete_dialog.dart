import 'package:flutter/material.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/service/map/trash_point/trash_point_service.dart';
import 'package:one/service/user_data/user_data_service.dart';
import 'package:provider/provider.dart';

class PointDeleteDialog {

  void showPointDeleteDialog(BuildContext context, String pointId) {
    final userData= Provider.of<UserData>(context, listen: false);
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(AppLocalization.of(context).pointDeleteDialogTitle,style: TextStyle(color: Colors.red),),
            content: Text(AppLocalization.of(context).pointDeleteDialogMessage),
            actions: <Widget>[
              new FlatButton(
                onPressed: () async {
                  TrashPointService().deletePoint(pointId);
                  UserDataService().decreaseUserAchievementField(userData.userDataId, 'pointsCreated');
                  Navigator.pop(context);
                },
                child: Text(AppLocalization.of(context).yesPlaceholder),),
              new FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text(AppLocalization.of(context).cancelPlaceholder),),
            ],
          );
        });
  }
}
