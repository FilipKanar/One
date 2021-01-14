import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one/model/map/cleaning.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/comment/comment_service.dart';
import 'package:one/service/file/image_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/service/map/cleaning/cleaning_service.dart';
import 'package:one/service/permission/PermissionService.dart';
import 'package:one/service/user_data/user_data_service.dart';
import 'package:one/shared/dialog/warning_dialog.dart';
import 'package:one/ui/home/screens/add_cleaning.dart';
import 'package:one/ui/home/screens/comments.dart';
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
        title: Text(widget.trashPoint.description,
            style: TextStyle(
              color: globals.appBarTitleColor,
            ),),
        leading: FlatButton(
          onPressed: () {
            widget.hideTrashPointMenuCallback();
          },
          child: Icon(Icons.arrow_downward, color: globals.green),
        ),
        actions: <Widget>[
          widget.trashPoint.cleaned ? Container() : FlatButton(
            child: Icon(
              Icons.add,
              color: globals.green,
            ),
            onPressed: () {
              if(userData.userId == test_user_data.testUserId){
                WarningDialog().showWarningDialog(context, AppLocalization.of(context).testUserWarningTitle, AppLocalization.of(context).testUserWarningMessage);
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
          WarningDialog().showWarningDialog(context, AppLocalization.of(context).noPictureProvidedErrorTitle,
              AppLocalization.of(context).noPictureProvidedErrorMessage);
        } else {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StreamProvider<UserData>.value(
                  value: UserDataService(userId: userData.userId).userData,
                  child: AddCleaning(image,widget.trashPoint),),
            ),
          );
        }
    }
  }
}
