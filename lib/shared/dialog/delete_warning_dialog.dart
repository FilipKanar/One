import 'package:flutter/material.dart';
import 'package:one/service/internationalization/app_localization.dart';
class DeleteWarningDialog {
  String title;
  String message;
  Function onPressed;
  DeleteWarningDialog(this.title,this.message,this.onPressed);

  void showAddPointDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title,style: TextStyle(color: Colors.red),),
            content: Text(message),
            actions: <Widget>[
              new FlatButton(
                onPressed: () async {
                    onPressed();
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
