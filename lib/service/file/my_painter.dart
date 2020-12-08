import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:one/model/touch_point.dart';

class MyPainter extends CustomPainter {

  List<TouchPoint> touchPointList;
  List<Offset> offsetPointList = List();

  MyPainter({this.touchPointList});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < touchPointList.length - 1; i++) {
      if (touchPointList[i] != null && touchPointList[i + 1] != null) {

        canvas.drawLine(touchPointList[i].points, touchPointList[i + 1].points,
            touchPointList[i].paint);
      } else if (touchPointList[i] != null && touchPointList[i + 1] == null) {
        offsetPointList.clear();
        offsetPointList.add(touchPointList[i].points);
        offsetPointList.add(Offset(
            touchPointList[i].points.dx + 0.1, touchPointList[i].points.dy + 0.1));

        canvas.drawPoints(PointMode.points, offsetPointList, touchPointList[i].paint);
      }
    }
  }
  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;

}