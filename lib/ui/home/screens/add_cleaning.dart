import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one/model/map/cleaning.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/file/image_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/service/map/cleaning/cleaning_service.dart';
import 'package:one/service/map/trash_point/trash_point_service.dart';
import 'package:one/shared/appbar/AppBarCustom.dart';
import 'package:one/shared/button/authentication_button.dart';
import 'package:one/ui/home/screens/edit_picture.dart';
import 'package:provider/provider.dart';

class AddCleaning extends StatefulWidget {
  final File imageFile;
  final TrashPoint trashPoint;

  AddCleaning(this.imageFile, this.trashPoint);

  @override
  _AddCleaningState createState() => _AddCleaningState();
}

class _AddCleaningState extends State<AddCleaning> {
  bool _wasImageEdited = false;
  final _formKey = GlobalKey<FormState>();
  File _imageFile;
  File _cleanImageFile;
  bool _lastCleaning = false;
  File _lastCleaningFile;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
    _cleanImageFile = _imageFile;
  }

  CleaningService cleaningService = CleaningService();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    addCleaning(newPicture) {
      CleaningService().addCleaning(
          Cleaning(pointId: widget.trashPoint.pointId, userId: userData.userId),
          newPicture,
          userData.userDataId);
    }

    addLastCleaning(newPicture) {
      Future.delayed(const Duration(milliseconds: 500), () {
        CleaningService().addCleaning(
            Cleaning(
                pointId: widget.trashPoint.pointId, userId: userData.userId),
            newPicture,
            userData.userDataId);
        TrashPointService().setPointCleaned(widget.trashPoint.pointId);
      });
    }

    return !_wasImageEdited
        ? EditPicture(
            image: _imageFile,
            callbackEditPicture: callbackEditPicture,
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBarCustom(
                title: AppLocalization.of(context).addCleaningDialogTitle,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text(AppLocalization.of(context)
                            .addCleaningDialogMessage),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                              width: 80,
                              height: 140,
                              image: FileImage(_imageFile),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.photo_camera_outlined,
                                    color: Colors.lightGreen,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    File temp =
                                        await ImageService().getCameraImage();
                                    if (temp != null) {
                                      setState(() {
                                        _imageFile = temp;
                                        _wasImageEdited = false;
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.lightGreen,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditPicture(
                                          image: _cleanImageFile,
                                          callbackEditPicture: (File picture) {
                                            if (picture != null)
                                              setState(
                                                  () => _imageFile = picture);
                                          },
                                          pop: true,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: _lastCleaning,
                                onChanged: (value) {
                                  setState(() {
                                    _lastCleaning = value;
                                  });
                                }),
                            Text(AppLocalization.of(context)
                                .lastTrashAtPointPlaceholder),
                          ],
                        ),
                        !_lastCleaning
                            ? AuthenticationButton().button(() {
                                addCleaning(_imageFile);
                                Navigator.pop(context);
                              }, AppLocalization.of(context).publicPlaceholder)
                            : Container(),
                        _lastCleaning
                            ? Column(
                                children: [
                                  Text(AppLocalization.of(context)
                                      .lastCleaningHintMessage),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _lastCleaningFile != null
                                          ? Image(
                                              width: 80,
                                              height: 140,
                                              image:
                                                  FileImage(_lastCleaningFile),
                                            )
                                          : Container(
                                              height: 140,
                                              width: 50,
                                              child: Image.asset(
                                                  'assets/logo/logo_no_text.png'),
                                            ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.photo_camera_outlined,
                                              color: Colors.lightGreen,
                                              size: 30,
                                            ),
                                            onPressed: () async {
                                              File temp = await ImageService()
                                                  .getCameraImage();
                                              if (temp != null) {
                                                setState(() {
                                                  _lastCleaningFile = temp;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(AppLocalization.of(context)
                                      .lastCleaningPublicHintMessage),
                                  AuthenticationButton().button(() {
                                    addCleaning(_imageFile);
                                    addLastCleaning(_lastCleaningFile);
                                    Navigator.pop(context);
                                  },
                                      AppLocalization.of(context)
                                          .lastCleaningPublicButtonText),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  callbackEditPicture(newImage) {
    setState(() {
      _wasImageEdited = true;
      _imageFile = newImage;
    });
  }
}
