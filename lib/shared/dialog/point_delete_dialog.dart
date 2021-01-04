import 'package:flutter/material.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/service/map/trash_point/trash_point_service.dart';

class PointDeleteDialog {

  void showAddPointDialog(BuildContext context, String pointId) {
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
