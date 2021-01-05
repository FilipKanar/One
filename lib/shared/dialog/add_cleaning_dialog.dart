import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one/service/file/image_service.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:one/shared/button/authentication_button.dart';
import 'package:one/ui/home/screens/edit_picture.dart';

/*Displays warning
* */
class AddCleaningDialog {
  final _formKey = GlobalKey<FormState>();

  void showAddCleaningDialogDialog(
      BuildContext context, File image, Function callBackEditPicture) {

    void _confirmButtonOnPressed(){
      Navigator.pop(context);
    }

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Row(
                  children: [
                    Container(
                      width: 50,
                      child: Image.asset('assets/logo/logo_no_text.png'),
                    ),
                    Text(AppLocalization
                        .of(context)
                        .addCleaningDialogTitle),
                  ],
                ),
                content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                  return SingleChildScrollView(
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
                                  width: 80,
                                  height: 140,
                                  image: FileImage(image),
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
                                          setState(() =>
                                            image = temp
                                          );
                                      }
                                    },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.lightGreen,
                                        size: 30,
                                      ),
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditPicture(
                                              image: image,
                                              callbackEditPicture: (File picture){
                                                if(picture!=null) setState(() => image=picture);
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
                          ],
                        ),
                      ),
                    ),
                  );}
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: AuthenticationButton().button(
                      _confirmButtonOnPressed,
                      'OK',
                      background: true,
                    ),
                  ),
                ],
              );}
            );
        });
  }
}
