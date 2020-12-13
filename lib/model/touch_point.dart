import 'package:flutter/material.dart';

//Model for single touch at Canvas
class TouchPoint {
//Style to use when drawing at Canvas
  Paint paint;
//Point representation
  Offset point;
  TouchPoint({this.paint,this.point});
}