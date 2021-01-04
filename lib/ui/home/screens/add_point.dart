import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one/model/map/cleaning.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/file/image_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/service/map/cleaning/cleaning_service.dart';
import 'package:one/service/map/trash_point/trash_point_service.dart';
import 'package:one/service/user_data/user_data_service.dart';
import 'package:one/shared/appbar/AppBarCustom.dart';
import 'package:one/shared/dialog/warning_dialog.dart';
import 'package:one/ui/home/screens/edit_picture.dart';
import 'package:provider/provider.dart';
import 'package:one/information/test_user_data.dart' as testUserData;
import 'package:one/information/globals.dart' as globals;

class AddPoint extends StatefulWidget {
  final LatLng latLng;
  final File imageFile;
  final Function updateCallback;

  AddPoint({this.imageFile, this.latLng, this.updateCallback});

  @override
  _AddPointState createState() => _AddPointState();
}

class _AddPointState extends State<AddPoint> {
  bool wasImageEdited = false;
  final _formKey = GlobalKey<FormState>();
  File _imageFile;


  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  //Services
  TrashPointService trashPointService = TrashPointService();
  CleaningService cleaningService = CleaningService();

  @override
  Widget build(BuildContext context) {
    TrashPoint trashPoint = TrashPoint(
        geoPoint: GeoPoint(widget.latLng.latitude, widget.latLng.longitude));
    final userData = Provider.of<UserData>(context);
    return !wasImageEdited
        ? EditPicture(
            image: _imageFile,
            callbackEditPicture: callbackEditPicture,
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBarCustom(
                title: AppLocalization.of(context).addPointPlaceholder,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            width: 150,
                            height: 300,
                            image: FileImage(_imageFile),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.photo_camera_outlined,
                                  color: Colors.lightGreen,
                                  size: 60,
                                ),
                                onPressed: () async {
                                  File temp =
                                      await ImageService().getCameraImage();
                                  if (temp != null) {
                                    setState(() {
                                      _imageFile = temp;
                                      wasImageEdited = false;
                                    });
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: TextFormField(
                          autofocus: true,
                          validator: (val) => val.length < 5
                              ? AppLocalization.of(context)
                                  .descriptionLengthValidator
                              : null,
                          onChanged: (val) => trashPoint.description = val,
                          decoration: InputDecoration(
                              hintText:
                                  AppLocalization.of(context).pointNameHintText,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lightGreen),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.lightGreen))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (userData.userId == testUserData.testUserId) {
                                WarningDialog().showWarningDialog(
                                    context,
                                    AppLocalization.of(context)
                                        .testUserWarningTitle,
                                    AppLocalization.of(context)
                                        .testUserWarningMessage);
                                WarningDialog().showWarningDialog(
                                    context,
                                    AppLocalization.of(context)
                                        .testUserWarningTitle,
                                    AppLocalization.of(context)
                                        .testUserWarningMessage);
                              } else {
                                trashPoint.cleaned = false;
                                trashPoint.creatorId = userData.userId;
                                await trashPointService
                                    .addTrashPoint(trashPoint);
                                cleaningService.addCleaning(
                                    Cleaning(
                                        pointId:
                                            trashPointService.returnPointId,
                                        userId: userData.userId,
                                        downloadPictureUrl: null),
                                    _imageFile,
                                    userData.userDataId);
                                UserDataService().increaseUserAchievementField(
                                    userData.userDataId, 'pointsCreated');
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            AppLocalization.of(context).publicPlaceholder,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  callbackEditPicture(newImage) {
    setState(() {
      wasImageEdited = true;
      _imageFile = newImage;
    });
  }
}
