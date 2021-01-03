import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:one/model/touch_point.dart';
import 'package:one/service/file/my_painter.dart';
import 'package:one/service/internationalization/app_localization.dart';
import 'package:screenshot/screenshot.dart';

class EditPicture extends StatefulWidget {
  final Function callbackEditPicture;
  final File image;
  final bool pop;

  EditPicture({ this.image,this.callbackEditPicture,this.pop=false});

  @override
  _EditPictureState createState() => _EditPictureState();
}

class _EditPictureState extends State<EditPicture> {
  List<TouchPoint> touchPointList = [];

  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 4.0;
  Color selectedColor = Colors.lightGreen;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              touchPointList.add(TouchPoint(
                  point: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = strokeType
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = strokeWidth));
            });
          },
          onPanStart: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              touchPointList.add(TouchPoint(
                  point: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = strokeType
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = strokeWidth));
            });
          },
          onPanEnd: (details) {
            setState(() {
              touchPointList.add(null);
            });
          },
          child: Stack(
            children: <Widget>[
              Center(
                child: Image(image: FileImage(widget.image),),
              ),
              CustomPaint(
                size: Size.infinite,
                painter: MyPainter(
                  touchPointList: touchPointList,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        heroTag: "paint_save",
        child: Icon(Icons.save,color: Colors.lightGreen,),
        tooltip: AppLocalization.of(context).saveAndContinueTip,
        onPressed: () {
          screenshotController.capture().then((File value) {
            widget.callbackEditPicture(value);
            if(widget.pop) Navigator.pop(context);
          }).catchError((onError) {
            print(onError);
          });
        },
      ),
    );
  }
}
