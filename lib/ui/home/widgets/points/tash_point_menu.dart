import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one/model/map/cleaning.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/comment/comment_service.dart';
import 'package:one/service/file/image_service.dart';
import 'package:one/service/map/cleaning/cleaning_service.dart';
import 'package:one/service/permission/PermissionService.dart';
import 'package:one/shared/dialog/warning_dialog.dart';
import 'package:one/ui/home/screens/comments.dart';
import 'package:one/ui/home/screens/edit_picture.dart';
import 'package:one/ui/home/widgets/image/horizontal_image_list.dart';
import 'package:provider/provider.dart';
import 'package:one/information/globals.dart' as globals;
import 'package:one/information/test_user_data.dart' as test_user_data;

class TrashPointMenu extends StatefulWidget {
  final TrashPoint trashPoint;
  final Function() hideTrashPointMenuCallback;

  TrashPointMenu({this.trashPoint, this.hideTrashPointMenuCallback});

  @override
  _PointMenuState createState() => _PointMenuState();
}

class _PointMenuState extends State<TrashPointMenu> {
  //Cleanings list
  List<Cleaning> cleaningList;

  //Services
  CleaningService cleaningService;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    cleaningList = Provider.of<List<Cleaning>>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.appBarColor,
        leading: FlatButton(
          onPressed: () {
            widget.hideTrashPointMenuCallback();
          },
          child: Icon(Icons.arrow_downward, color: globals.green),
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.add,
              color: globals.green,
            ),
            onPressed: () {
              if(userData.userId == test_user_data.testUserId){
                WarningDialog().showWarningDialog(context, globals.testUserWarningTitle, globals.testUserWarningMessage);
              } else {
                addCleaning(userData);
              }
            },
          ),
          FlatButton(
            child: Icon(
              Icons.comment,
              color: globals.green,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StreamProvider.value(
                    value: CommentService()
                        .getCommentsAtPoint(widget.trashPoint.pointId),
                    child: Comments(
                      userData: userData,
                      trashPoint: widget.trashPoint,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: HorizontalImageList(
        cleaningsList: cleaningList,
      ),
    );
  }

  addCleaning(UserData userData) async {
      if (await PermissionService().awaitCameraPermission()) {
        File image = await ImageService().getCameraImage();
        if (image == null) {
          WarningDialog().showWarningDialog(context, 'Picture',
              'Take picture of littered place. Select ONE trash you will throw out. Be happy.');
        } else {
          callBackEditPicture(newPicture) {
            CleaningService().addCleaning(
                Cleaning(
                    pointId: widget.trashPoint.pointId,
                    userId: userData.userId),
                newPicture,
                userData.userDataId);
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPicture(
                image: image,
                callbackEditPicture: callBackEditPicture,
                pop: true,
              ),
            ),
          );
        }
    }
  }
}
