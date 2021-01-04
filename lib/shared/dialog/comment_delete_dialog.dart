import 'package:flutter/material.dart';
import 'package:one/service/comment/comment_service.dart';
import 'package:one/service/internationalization/app_localization.dart';

class CommentDeleteDialog {

  void showAddPointDialog(BuildContext context, String commentId) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(AppLocalization.of(context).commentDeleteDialogTitle,style: TextStyle(color: Colors.red),),
            content: Text(AppLocalization.of(context).commentDeleteDialogMessage),
            actions: <Widget>[
              new FlatButton(
                onPressed: () async {
                  CommentService().deleteComment(commentId);
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
