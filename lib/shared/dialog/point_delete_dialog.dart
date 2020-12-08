import 'package:flutter/material.dart';
import 'package:one/service/map/trash_point/trash_point_service.dart';

class PointDeleteDialog {

  void showAddPointDialog(BuildContext context, String pointId) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Delete',style: TextStyle(color: Colors.red),),
            content: Text('Are you sure that you want to permanently delete the selected point?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () async {
                  TrashPointService().deletePoint(pointId);
                  Navigator.pop(context);
                },
                child: Text('Yes'),),
              new FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text('No'),),
            ],
          );
        });
  }
}
