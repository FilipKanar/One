import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {

  final String text;
  final double fontSize;
  TextCustom({this.text='empty',this.fontSize=8});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(3),child: Text(text, style: TextStyle(fontSize: fontSize),));
  }
}
